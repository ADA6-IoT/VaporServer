//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct UnssignedDeviceQuery: Content {
    let excludeMalfunctioning: Bool?
    let minBattery: Int?
    
    enum CodingKeys: String, CodingKey {
        case excludeMalfunctioning = "exclude_malfunctioning"
        case minBattery = "min_battery"
    }
}

struct UnssignedDeviceResponse: Content {
    let totalCount: Int
    let devices: [DeviceDTO]
}
