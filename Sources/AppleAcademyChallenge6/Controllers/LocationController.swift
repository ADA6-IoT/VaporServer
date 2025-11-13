//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor
import Fluent

struct LocationController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let locations = routes.grouped("api", "locatoins")
        locations.post("calculate", use: calculateLocation)
    }
    
    func calculateLocation(_ req: Request) async throws -> CommonResponseDTO<LocationCalculateResponseDTO> {
        let dto = try req.content.decode(LocationCalculateRequestDTO.self)
        let locatoinService = req.di.makeLocationService(request: req)
        
        let result = try await locatoinService.calculateLocation(
            serialNumber: dto.serialNumber,
            batteryLevel: dto.batteryLevel,
            floor: dto.floor,
            measurements: dto.measurements
        )
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "위치 게산 성공", result: result)
    }
}
