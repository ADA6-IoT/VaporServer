//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/10/25.
//

import Vapor

struct RoomSimpleDTO: Content {
    let id: UUID
    let roomNumber: String
    let bedCount: Int
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case roomNumber = "room_number"
        case bedCount = "bed_count"
        case isAvailable = "is_available"
    }
    
    init(from room: Room) {
           self.id = room.id!
           self.roomNumber = room.roomNumber
           self.bedCount = room.bedCount
           self.isAvailable = room.isAvailable
       }
}
