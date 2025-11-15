//
//  DashboardController.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/15/25.
//

import Vapor
import Fluent
import VaporToOpenAPI

struct DashboardController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let dashboard = routes.grouped("api", "dashboard")
        let protected = dashboard.grouped(JWTMiddleware())

        // 내 병원 통계
        protected.get("my-stats", use: getMyHospitalStats)
            .openAPI(
                tags: TagObject(name: "Dashboard"),
                summary: "내 병원 통계 조회",
                description: "로그인한 병원의 통계 정보를 조회합니다. (앵커, 환자, 디바이스, 병실, 부서, 리포트, 에러 수)",
                response: .type(CommonResponseDTO<HospitalStatsResponse>.self)
            )

        // 디바이스 상태 통계
        protected.get("device-stats", use: getDeviceStats)
            .openAPI(
                tags: TagObject(name: "Dashboard"),
                summary: "디바이스 상태 통계",
                description: "병원의 디바이스 상태별 통계를 조회합니다. (정상, 고장, 저배터리, 사용중)",
                response: .type(CommonResponseDTO<DeviceStatsResponse>.self)
            )

        // 에러 통계
        protected.get("error-stats", use: getErrorStats)
            .openAPI(
                tags: TagObject(name: "Dashboard"),
                summary: "에러 통계",
                description: "병원의 에러 발생 통계를 조회합니다. (전체, 오늘, 이번주, 상태코드별)",
                response: .type(CommonResponseDTO<ErrorStatsResponse>.self)
            )

        // 전체 병원 목록 (관리자용)
        protected.get("hospitals", use: getAllHospitals)
            .openAPI(
                tags: TagObject(name: "Dashboard"),
                summary: "전체 병원 목록 조회",
                description: "모든 병원의 요약 정보를 조회합니다.",
                response: .type(CommonResponseDTO<[HospitalSummaryResponse]>.self)
            )
    }

    // 내 병원 통계
    func getMyHospitalStats(_ req: Request) async throws -> CommonResponseDTO<HospitalStatsResponse> {
        let sessionToken = try req.requireAuth()
        let hospitalId = sessionToken.hospitalId

        let stats = try await buildHospitalStats(hospitalId: hospitalId, db: req.db)

        return CommonResponseDTO.success(
            code: ResponseCode.COMMON200,
            message: "병원 통계 조회 성공",
            result: stats
        )
    }

    // 디바이스 상태 통계
    func getDeviceStats(_ req: Request) async throws -> CommonResponseDTO<DeviceStatsResponse> {
        let sessionToken = try req.requireAuth()
        let hospitalId = sessionToken.hospitalId

        // 전체 디바이스 수
        let totalDevices = try await Device.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        // 고장난 디바이스 수
        let malfunctioningDevices = try await Device.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$isMalfunctioning == true)
            .count()

        // 정상 디바이스 수
        let normalDevices = totalDevices - malfunctioningDevices

        // 저배터리 디바이스 수 (20% 이하)
        let lowBatteryDevices = try await Device.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$batteryLevel <= 20)
            .count()

        // 환자에게 할당된 디바이스 수
        let devicesInUse = try await Patient.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$device.$id != nil)
            .count()

        let stats = DeviceStatsResponse(
            totalDevices: totalDevices,
            normalDevices: normalDevices,
            malfunctioningDevices: malfunctioningDevices,
            lowBatteryDevices: lowBatteryDevices,
            devicesInUse: devicesInUse
        )

        return CommonResponseDTO.success(
            code: ResponseCode.COMMON200,
            message: "디바이스 통계 조회 성공",
            result: stats
        )
    }

    // 에러 통계
    func getErrorStats(_ req: Request) async throws -> CommonResponseDTO<ErrorStatsResponse> {
        let sessionToken = try req.requireAuth()
        let hospitalId = sessionToken.hospitalId

        // 전체 에러 수
        let totalErrors = try await ErrorLog.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        // 오늘 에러 수
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let errorsToday = try await ErrorLog.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$createdAt >= startOfToday)
            .count()

        // 이번 주 에러 수
        let startOfWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let errorsThisWeek = try await ErrorLog.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$createdAt >= startOfWeek)
            .count()

        // 상태 코드별 에러 수 (최근 30일)
        let last30Days = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
        let recentErrors = try await ErrorLog.query(on: req.db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$createdAt >= last30Days)
            .all()

        // 상태 코드별로 그룹화
        var statusCodeCounts: [Int: Int] = [:]
        for error in recentErrors {
            statusCodeCounts[error.statusCode, default: 0] += 1
        }

        let errorsByStatusCode = statusCodeCounts.map {
            StatusCodeCount(statusCode: $0.key, count: $0.value)
        }.sorted { $0.count > $1.count }

        let stats = ErrorStatsResponse(
            totalErrors: totalErrors,
            errorsToday: errorsToday,
            errorsThisWeek: errorsThisWeek,
            errorsByStatusCode: errorsByStatusCode
        )

        return CommonResponseDTO.success(
            code: ResponseCode.COMMON200,
            message: "에러 통계 조회 성공",
            result: stats
        )
    }

    // 전체 병원 목록
    func getAllHospitals(_ req: Request) async throws -> CommonResponseDTO<[HospitalSummaryResponse]> {
        let hospitals = try await HospitalAccount.query(on: req.db)
            .all()

        var summaries: [HospitalSummaryResponse] = []

        for hospital in hospitals {
            guard let hospitalId = hospital.id else { continue }

            let patientCount = try await Patient.query(on: req.db)
                .filter(\.$hospital.$id == hospitalId)
                .count()

            let deviceCount = try await Device.query(on: req.db)
                .filter(\.$hospital.$id == hospitalId)
                .count()

            let summary = HospitalSummaryResponse(
                hospitalId: hospitalId,
                hospitalName: hospital.hospitalName,
                businessNumber: hospital.businessNumber,
                email: hospital.email,
                totalPatients: patientCount,
                totalDevices: deviceCount,
                createdAt: hospital.createdAt
            )

            summaries.append(summary)
        }

        return CommonResponseDTO.success(
            code: ResponseCode.COMMON200,
            message: "전체 병원 목록 조회 성공",
            result: summaries
        )
    }

    // 병원 통계 생성 헬퍼 함수
    private func buildHospitalStats(hospitalId: UUID, db: any Database) async throws -> HospitalStatsResponse {
        // 병원 정보
        guard let hospital = try await HospitalAccount.find(hospitalId, on: db) else {
            throw Abort(.notFound, reason: "병원을 찾을 수 없습니다.")
        }

        // 앵커 통계
        let totalAnchors = try await Anchor.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        let activeAnchors = try await Anchor.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$isActive == true)
            .count()

        // 환자 수
        let totalPatients = try await Patient.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        // 디바이스 통계
        let totalDevices = try await Device.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        let malfunctioningDevices = try await Device.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$isMalfunctioning == true)
            .count()

        // 병실 통계
        let totalRooms = try await Room.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        let availableRooms = try await Room.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$isAvailable == true)
            .count()

        // 부서 수
        let totalDepartments = try await Department.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        // 리포트 통계
        let totalReports = try await Report.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .count()

        let pendingReports = try await Report.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$status == .pending)
            .count()

        // 최근 24시간 에러 수
        let last24Hours = Calendar.current.date(byAdding: .hour, value: -24, to: Date()) ?? Date()
        let recentErrorCount = try await ErrorLog.query(on: db)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$createdAt >= last24Hours)
            .count()

        return HospitalStatsResponse(
            hospitalId: hospitalId,
            hospitalName: hospital.hospitalName,
            totalAnchors: totalAnchors,
            activeAnchors: activeAnchors,
            totalPatients: totalPatients,
            totalDevices: totalDevices,
            malfunctioningDevices: malfunctioningDevices,
            totalRooms: totalRooms,
            availableRooms: availableRooms,
            totalDepartments: totalDepartments,
            totalReports: totalReports,
            pendingReports: pendingReports,
            recentErrorCount: recentErrorCount
        )
    }
}
