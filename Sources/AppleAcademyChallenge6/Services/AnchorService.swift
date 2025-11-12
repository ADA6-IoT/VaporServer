//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/12/25.
//

import Vapor
import Fluent

final class AnchorService: ServiceProtocol {
    var database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    // MARK: - 앵커 전체 조회
    func gerAllAnchors(hospitalId: UUID) async throws -> [Anchor] {
        try await Anchor.query(on: database)
            .filter(\.$hospital.$id == hospitalId)
            .all()
    }
    
    // MARK: - 층별 앵커 조회
    func getAnchorsByFloor(floor: Int, hospitalId: UUID) async throws -> [Anchor] {
        try await Anchor.query(on: database)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$floor == floor)
            .all()
    }
    
    // MARK:  - 앵커 등록
    func createAnchor(
        hospitalId: UUID,
        macAddress: String,
        zoneType: String,
        zoneName: String,
        floor: Int,
        positionX: Double,
        positionY: Double,
        positionZ: Double?
    ) async throws -> Anchor {
        if let _ = try await Anchor.query(on: database)
            .filter(\.$macAddress == macAddress)
            .first() {
            throw Abort(.conflict, reason: "앵커 맥 주소 이미 존재합니다.")
        }
        
        let anchor = Anchor(
            hospitalId: hospitalId,
            macAddress: macAddress,
            zoneType: zoneType,
            zoneName: zoneName,
            floor: floor,
            positionX: positionX,
            positionY: positionY,
            positionZ: positionZ
        )
        
        try await anchor.save(on: database)
        
        return anchor
    }
    
    // MARK: - 앵커 수정
    func updateAnchor(
        id: UUID,
        hospitalId: UUID,
        zoneType: String?,
        zoneName: String?,
        floor: Int?,
        positionX: Double?,
        positionY: Double?,
        positionZ: Double?
    ) async throws -> Anchor {
        guard let anchor = try await Anchor.query(on: database)
            .filter(\.$id == id)
            .filter(\.$hospital.$id == hospitalId)
            .first() else {
            throw Abort(.notFound, reason: "앵커를 찾을 수 없습니다.")
        }
        
        if let zoneType = zoneType {
            anchor.zoneType = zoneType
        }
        
        if let zoneName = zoneName {
            anchor.zoneName = zoneName
        }
        
        if let floor = floor {
            anchor.floor = floor
        }
        
        if let positionY = positionY {
            anchor.positionY = positionY
        }
        
        if let positionZ = positionZ {
            anchor.positionZ = positionZ
        }
        
        try await anchor.save(on: database)
        
        return anchor
    }
    
    // MARK:  - 앵커 삭제
    func deleteAnchort(id: UUID, hospitalId: UUID) async throws {
        guard let anchor = try await Anchor.query(on: database)
            .filter(\.$id == id)
            .filter(\.$hospital.$id == hospitalId)
            .first() else {
            throw Abort(.notFound, reason: "앵커를 찾을 수 없습니다.")
        }
        
        try await anchor.delete(on: database)
    }
}
