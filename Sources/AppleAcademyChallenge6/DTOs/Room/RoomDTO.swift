//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/10/25.
//

import Vapor

struct RoomDTO: Content {
    let id: UUID
    let floor: Int
    let roomNumber: String
    let bedCount: Int
    let isAvailable: Bool
    let createdAt: Date?
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, floor
        case roomNumber = "room_number"
        case bedCount = "bed_count"
        case isAvailable = "is_available"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from room: Room) {
        self.id = room.id!
        self.floor = room.floor
        self.roomNumber = room.roomNumber
        self.bedCount = room.bedCount
        self.isAvailable = room.isAvailable
        self.createdAt = room.createdAt
        self.updatedAt = room.updatedAt
    }
}
