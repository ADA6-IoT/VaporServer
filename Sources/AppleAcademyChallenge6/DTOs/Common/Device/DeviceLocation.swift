//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DeviceLocation: Content {
    let zoneType: String
    let zoneName: String
    let floor: Int
    let precisePosition: DevicePrecisePosition
    let distanceFromAnchor: Double
    let lastUpdate: String
    
    enum CodingKeys: String, CodingKey {
        case zoneType = "zone_type"
        case zoneName = "zone_name"
        case floor
        case precisePosition = "precise_position"
        case distanceFromAnchor = "distance_from_anchor"
        case lastUpdate = "last_update"
    }
}
