//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor

struct AnchorController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let anchors = routes.grouped("api", "anchors")
        let protected = anchors.grouped(JWTMiddleware())
        
        // TODO: - Path
        protected.get("all", use: list)
        protected.get("floor", use: getByFloor)
        protected.post("create", use: create)
        protected.patch("update", use: update)
        protected.delete(use: delete)
    }
    
    func list(_ req: Request) async throws -> CommonResponseDTO<[AnchorDTO]> {
        let sessionToken = try req.requireAuth()
        let service = req.di.makeAnchorService(request: req)
        let anchors = try await service.getAllAnchors(hospitalId: sessionToken.hospitalId)
        let result = anchors.map { AnchorDTO(from: $0) }
        
        return CommonResponseDTO.success(
            code: ResponseCode.COMMON200,
            message: "앵커 목록 조회 성공",
            result: result)
    }
    
    func getByFloor(_ req: Request) async throws -> CommonResponseDTO<[AnchorDTO]> {
        let sessionToken = try req.requireAuth()
        let floor = try req.parameters.require("floor", as: Int.self)
        let service = req.di.makeAnchorService(request: req)
        let anchors = try await service.getAnchorsByFloor(floor: floor, hospitalId: sessionToken.hospitalId)
        let result = anchors.map { AnchorDTO(from: $0) }
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "층별 앵커 조회 성공", result: result)
    }
    
    func create(_ req: Request) async throws -> CommonResponseDTO<AnchorDTO> {
        let dto = try req.content.decode(AnchorAddRequest.self)
        let sessionToken = try req.requireAuth()
        let service = req.di.makeAnchorService(request: req)
        
        let anchor = try await service.createAnchor(
            hospitalId: sessionToken.hospitalId,
            macAddress: dto.macAddress,
            zoneType: dto.zoneType,
            zoneName: dto.zoneName,
            floor: dto.floor,
            positionX: dto.positionX,
            positionY: dto.positionY,
            positionZ: dto.positionZ
        )
        
        let result = AnchorDTO(from: anchor)
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "앵커 생성 성공", result: result
        )
    }
    
    func update(_ req: Request) async throws -> CommonResponseDTO<AnchorDTO> {
        let dto = try req.content.decode(AnchorUpdateRequest.self)
        let sesstionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makeAnchorService(request: req)
        
        let anchor = try await service.updateAnchor(
            id: id,
            hospitalId: sesstionToken.hospitalId,
            zoneType: dto.zoneType,
            zoneName: dto.zoneName,
            floor: dto.floor,
            positionX: dto.positionX,
            positionY: dto.positionY,
            positionZ: dto.positionZ
        )
        
        let result = AnchorDTO(from: anchor)
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "앵커 수정 성공", result: result)
    }
    
    func delete(_ req: Request) async throws -> CommonResponseDTO<EmptyResponse> {
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makeAnchorService(request: req)
        
        try await service.deleteAnchort(id: id, hospitalId: sessionToken.hospitalId)
        
        return CommonResponseDTO.successNoData(code: ResponseCode.COMMON200, message: "앵커 삭제 성공")
    }
}
