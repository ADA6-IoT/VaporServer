//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/10/25.
//

import Vapor

struct BulkCreateRoomsRequestDTO: Content {
    let rooms: [RoomDefinition]
    
    struct RoomDefinition: Content {
        let floor: Int
        let roomNumbers: [String]
        let bedCount: Int
        
        enum CodingKeys: String, CodingKey {
            case floor
            case roomNumbers = "room_numbers"
            case bedCount = "bed_count"
        }
        
        func validate() throws {
            guard floor > 0 else {
                throw Abort(.badRequest, reason: "0층이 존재할 수 없어요")
            }
            
            guard !roomNumbers.isEmpty else {
                throw Abort(.badRequest, reason: "방 번호가 비워있습니다.")
            }
            
            guard bedCount > 0 else {
                throw Abort(.badRequest, reason: "숫자가 잘못되었어요")
            }
        }
    }
    
    func validate() throws {
            guard !rooms.isEmpty else {
                throw Abort(.badRequest, reason: "Rooms cannot be empty")
            }
            
            for room in rooms {
                try room.validate()
            }
        }
}
