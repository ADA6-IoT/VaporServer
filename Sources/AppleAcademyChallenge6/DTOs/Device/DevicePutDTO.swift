//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DevicePutPath: Content {
    let id: UUID
}

struct DevicePutRequest: Content {
    let name: String?
    let isMalfunctioning: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name
        case isMalfunctioning = "is_malfunctioning"
    }
}

struct DevicePutResponse: Content {
    let name: String
    let device: Device
    
    struct Device: Content {
        let id: UUID
        let hospitalId: UUID
        let serialNumber: String
        let name: String
        let batteryLevel: Int
        let signalLevel: Int
        let currentLocation: String?
        let isMalfunctioning: Bool
        let isAssigned: Bool
        let assignedTo: String?
        let createdAt: Date
        let updatedAt: Date
        
        enum CodingKeys: String, CodingKey {
            case id
            case hospitalId = "hospital_id"
            case serialNumber = "serial_number"
            case name
            case batteryLevel = "battery_level"
            case signalLevel = "signal_level"
            case currentLocation = "current_location"
            case isMalfunctioning = "is_malfunctioning"
            case isAssigned = "is_assigned"
            case assignedTo = "assigned_to"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}
