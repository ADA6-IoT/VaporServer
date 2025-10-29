//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 위도, 경도 값
struct CalculateRequest: Content {
    let serialNumber: String
    let batteryLevel: Int
    let floor: Int
    let timestamp: String
    let measurements: [MeasurementDTO]
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case floor
        case timestamp
        case measurements
    }
}

struct MeasurementDTO: Content {
    let anchorMac: String
    let distanceMeters: Double
    let rttNanoseconds: Int
    let rssi: Int
    
    enum CodingKeys: String, CodingKey {
        case anchorMac = "anchor_mac"
        case distanceMeters = "distance_meters"
        case rttNanoseconds = "rtt_nanoseconds"
        case rssi
    }
}
