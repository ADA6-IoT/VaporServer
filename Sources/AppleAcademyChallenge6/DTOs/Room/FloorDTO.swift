//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/10/25.
//

import Vapor

struct FloorDTO: Content {
    let floor: Int
    let rooms: [RoomSimpleDTO]
    
    init(floor: Int, rooms: [Room]) {
            self.floor = floor
            self.rooms = rooms.map { RoomSimpleDTO(from: $0) }
        }
}

struct RoomGroupedByFloorDTO: Content {
    let floors: [FloorDTO]
    
    init(rooms: [Room]) {
        let groupedByFloor = Dictionary(grouping: rooms, by: { $0.floor })
        
        let sortedFloors = groupedByFloor.keys.sorted()
        
        self.floors = sortedFloors.map { floor in
            let roomsInFloor = groupedByFloor[floor] ?? []
            
            let sortedRooms = roomsInFloor.sorted(by: { $0.roomNumber < $1.roomNumber })
            return FloorDTO(floor: floor, rooms: sortedRooms)
        }
    }
}
