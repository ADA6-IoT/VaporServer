//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/10/25.
//

import Vapor

struct CreateRoomRequestDTO: Content {
    let floor: Int
    let roomNumber: String
    let bedCount: Int
    
    enum CodingKeys: String, CodingKey {
        case floor
        case roomNumber = "room_number"
        case bedCount = "bed_count"
    }
    
    func validate() throws {
        guard floor > 0 else {
            throw Abort(.badRequest, reason: "0층이 없습니다.")
        }
        
        guard !roomNumber.isEmpty else {
            throw Abort(.badRequest, reason: "룸 번호 비워있습니다.")
        }
        
        guard bedCount > 0 else {
            throw Abort(.badRequest, reason: "침대 수는 0보다 많아야 해요")
        }
    }
}


struct UpdateRoomRequestDTO: Content {
    let bedCount: Int?
    let roomType: String?
    let isAvailable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case bedCount = "bed_count"
        case roomType = "room_type"
        case isAvailable = "is_available"
    }
    
    func validate() throws {
        if let bedCount = bedCount {
            guard bedCount > 0 else {
                throw Abort(.badRequest, reason: "Bed count must be greater than 0")
            }
        }
    }
}
