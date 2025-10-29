//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/29/25.
//

import Vapor

struct PatientDTO: Content {
    let id: UUID
    let name: String
    let ward: WardDTO
    let bed: BedDTO
    let department: DepartmentDTO
    let memo: String
    let device: DeviceStatus?
    let currentLocation: CurrentLocationDTO?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ward
        case bed
        case department
        case memo
        case device
        case currentLocation = "current_location"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct WardDTO: Content {
    let id: UUID
    let name: String
}

struct BedDTO: Content {
    let id: UUID
    let name: String
}

struct DepartmentDTO: Content {
    let id: UUID
    let name: String
}

struct DeviceStatus: Content {
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
    }
}

struct CurrentLocationDTO: Content {
    let zoneType: String
    let zoneName: String
    let floor: Int
    let isInAssignedWard: Bool
    let precisePosition: DevicePrecisePosition
    let lastUpdate: Date
    
    enum CodingKeys: String, CodingKey {
        case zoneType = "zone_type"
        case zoneName = "zone_name"
        case floor
        case isInAssignedWard = "is_in_assigned_ward"
        case precisePosition = "precise_position"
        case lastUpdate = "last_update"
    }
}
