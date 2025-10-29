//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DeviceReportRequest: Content {
    let deviceIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case deviceIds = "device_ids"
    }
}

struct DeviceReportResponse: Content {
    let deviceId: UUID
    let serialNumber: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case serialNumber = "serial_number"
        case status
    }
}
