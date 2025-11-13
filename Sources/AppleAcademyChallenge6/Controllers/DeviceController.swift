//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor

struct DeviceController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let devices = routes.grouped("api", "devices")
        let protected = devices.grouped(JWTMiddleware())
        
        protected.get(use: getAll)
        protected.post(use: register)
        protected.post("malfunction", use: reportMalfunctions)
        protected.post(":serialNumber", use: delete)
    }
    
    func getAll(_ req: Request) async throws -> CommonResponseDTO<[DeviceDTO]> {
        let sessionToken = try req.requireAuth()
        let service = req.di.makeDeviceService(request: req)
        
        let devices = try await service.getAllDevices(hospitalId: sessionToken.hospitalId)
        
        let result = devices.map { DeviceDTO(from: $0) }
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "기기 목록 조회 성공", result: result)
    }
    
    func register(_ req: Request) async throws -> CommonResponseDTO<DeviceDTO> {
        let dto = try req.content.decode(DeviceAddRequest.self)
        
        let sessionToken = try req.requireAuth()
        let service = req.di.makeDeviceService(request: req)
        
        let device = try await service.creatreDevice(
            hospitalId: sessionToken.hospitalId,
            serialNumber: dto.serialNumber
        )
        
        let result = DeviceDTO(from: device)
        
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "기기 등록 성공", result: result)
    }
    
    func reportMalfunctions(_ req: Request) async throws -> CommonResponseDTO<BulkMalfunctionResult> {
        let dto = try req.content.decode(ReportMalfunctionRequest.self)
        let sessionToken = try req.requireAuth()
        let service = req.di.makeDeviceService(request: req)
        
        let result = try await service.reportMalfunctions(
            serialNumbers: dto.serialNumber,
            hospitalId: sessionToken.hospitalId
        )
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "기기 고장 신고 완료", result: result)
    }
    
    func delete(_ req: Request) async throws -> CommonResponseDTO<EmptyResponse> {
        let sessionToken = try req.requireAuth()
        let serialNumber = try req.parameters.require("serialNumber", as: String.self)
        
        let service = req.di.makeDeviceService(request: req)
        try await service.deleteDevice(serialNumber: serialNumber, hospitalId: sessionToken.hospitalId)
        
        return CommonResponseDTO.successNoData(code: ResponseCode.COMMON200, message: "기기 삭제 성공")
    }
}
