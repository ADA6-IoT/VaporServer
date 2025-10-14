//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

struct DeviceReportRequestDTO: Content {
    let reports: DeviceReports
}

struct DeviceReports: Content {
    let serialNumber: String
    let reportContents: [String]
}
