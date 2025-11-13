//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor
import Fluent

struct PatientController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let patients = routes.grouped("api", "patients")
        let protected = patients.grouped(JWTMiddleware())
        
        protected.get("all", use: list)
        protected.get("ward", ":ward", use: getByWard)
        protected.get(":id", use: get)
        protected.post("create", use: create)
        protected.patch(":id", use: update)
        protected.delete(":id", use: delete)
    }
    
    func list(_ req: Request) async throws -> CommonResponseDTO<[PatientDTO]> {
        let sessionToken = try req.requireAuth()
        let service = req.di.makePatientService(request: req)
        let patients = try await service.getAllPatients(hospitalId: sessionToken.hospitalId)
        let result = patients.map { PatientDTO(from: $0) }
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "환자 목록 조회 성공", result: result)
    }
    
    func getByWard(_ req: Request) async throws -> CommonResponseDTO<[PatientDTO]> {
        let sessionToken = try req.requireAuth()
        let ward = try req.parameters.require("ward", as: String.self)
        let service = req.di.makePatientService(request: req)
        let patients = try await service.getPatientsByWard(ward: ward, hospitalId: sessionToken.hospitalId)
        let result = patients.map { PatientDTO(from: $0) }
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "병동별 환자 조회 성공", result: result)
    }
    
    func get(_ req: Request) async throws -> CommonResponseDTO<PatientDetailResponse> {
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makePatientService(request: req)
        let patient = try await service.getPatient(id: id, hospitalId: sessionToken.hospitalId)
        let result = PatientDetailResponse(from: patient)
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "환자 상세 조회 성공", result: result)
    }
    
    func create(_ req: Request) async throws -> CommonResponseDTO<PatientDTO> {
        let dto = try req.content.decode(PatientAddRequest.self)
        let sessionToken = try req.requireAuth()
        let service = req.di.makePatientService(request: req)
        
        let patient = try await service.createPatient(
            hospitalId: sessionToken.hospitalId,
            name: dto.name,
            ward: dto.ward,
            bed: dto.bed,
            departmentId: dto.departmentId,
            deviceSerial: dto.deviceSerial,
            memo: dto.memo
        )
        
        try await patient.$device.load(on: req.db)
        try await patient.$department.load(on: req.db)
        
        let result = PatientDTO(from: patient)
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "환자 등록 성공", result: result)
    }
    
    func update(_ req: Request) async throws -> CommonResponseDTO<PatientDTO> {
        let dto = try req.content.decode(PatientUpdateRequest.self)
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makePatientService(request: req)
        
        let patient = try await service.updatePatient(
            id: id,
            hospitalId: sessionToken.hospitalId,
            name: dto.name,
            ward: dto.ward,
            bed: dto.bed,
            departmentId: dto.departmentId,
            memo: dto.memo
        )
        
        try await patient.$device.load(on: req.db)
        try await patient.$department.load(on: req.db)
        
        let result = PatientDTO(from: patient)
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "환자 수정 성공", result: result
        )
    }
    
    func delete(_ req: Request) async throws -> CommonResponseDTO<EmptyResponse> {
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makePatientService(request: req)
        
        try await service.deletePatient(id: id, hospitalId: sessionToken.hospitalId)
        
        return CommonResponseDTO.successNoData(code: ResponseCode.COMMON200, message: "환자 삭제 성공")
    }
}
