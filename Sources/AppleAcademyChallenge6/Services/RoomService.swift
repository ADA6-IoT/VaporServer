//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/12/25.
//

import Vapor
import Fluent

struct RoomService: ServiceProtocol {
    var database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    // MARK: - 방생성
    func create(
        hospitalId: UUID,
        floor: Int,
        roomNumber: String,
        bedCount: Int,
        roomType: String?
    ) async throws -> Room {
        let existing = try await Room.query(on: database)
            .filter(\.$hospital.$id == hospitalId)
            .filter(\.$roomNumber == roomNumber)
            .first()
        
        if existing != nil {
            throw Abort(.conflict, reason: "Room \(roomNumber) 이미 존재합니다.")
        }
        
        let room = Room(
            hospitalId: hospitalId,
            floor: floor,
            roomNumber: roomNumber,
            bedCount: bedCount,
            roomType: roomType
        )
        
        try await room.save(on: database)
        
        return room
    }
    
    func bulkCreate(
        hospitalId: UUID,
        rooms: [BulkCreateRoomsRequestDTO.RoomDefinition]
    ) async throws -> [Room] {
        var createdRooms: [Room] = []
        
        for roomDef in rooms {
            for roomNumber in roomDef.roomNumbers {
                let existing = try await Room.query(on: database)
                    .filter(\.$hospital.$id == hospitalId)
                    .filter(\.$roomNumber == roomNumber)
                    .first()
                
                if existing == nil {
                    let room = Room(
                        hospitalId: hospitalId,
                        floor: roomDef.floor,
                        roomNumber: roomNumber,
                        bedCount: roomDef.bedCount
                        )
                    createdRooms.append(room)
                }
            }
        }
        
        guard !createdRooms.isEmpty else {
            throw Abort(.conflict, reason: "모든 방이 이미 존재합니다.")
        }
        
        try await createdRooms.create(on: database)
        
        return createdRooms
    }
    
    // MARK: - Read
    
    func list(hospitalId: UUID) async throws -> [Room] {
           try await Room.query(on: database)
               .filter(\.$hospital.$id == hospitalId)
               .sort(\.$floor, .ascending)
               .sort(\.$roomNumber, .ascending)
               .all()
       }
       
       func listByFloor(hospitalId: UUID, floor: Int) async throws -> [Room] {
           try await Room.query(on: database)
               .filter(\.$hospital.$id == hospitalId)
               .filter(\.$floor == floor)
               .sort(\.$roomNumber, .ascending)
               .all()
       }
       
       func search(hospitalId: UUID, keyword: String) async throws -> [Room] {
           try await Room.query(on: database)
               .filter(\.$hospital.$id == hospitalId)
               .filter(\.$roomNumber ~~ keyword)
               .sort(\.$floor, .ascending)
               .sort(\.$roomNumber, .ascending)
               .all()
       }
       
       func get(id: UUID, hospitalId: UUID) async throws -> Room {
           guard let room = try await Room.query(on: database)
               .filter(\.$id == id)
               .filter(\.$hospital.$id == hospitalId)
               .first() else {
               throw Abort(.notFound, reason: "Room not found")
           }
           
           return room
       }
    
    // MARK: - Delete
    func delete(id: UUID, hospitalId: UUID) async throws {
           guard let room = try await Room.query(on: database)
               .filter(\.$id == id)
               .filter(\.$hospital.$id == hospitalId)
               .first() else {
               throw Abort(.notFound, reason: "Room not found")
           }
           
           try await room.delete(on: database)
       }
       
       func deleteAll(hospitalId: UUID) async throws {
           try await Room.query(on: database)
               .filter(\.$hospital.$id == hospitalId)
               .delete()
       }
    
}
