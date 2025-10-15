//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Vapor
import Fluent

final class DeviceReport: Model, Content, @unchecked Sendable {
    static let schema: String = "device_report"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "serial_number")
    var device: Device
    
    @Field(key: "reporting_contents")
    var contents: [String]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        device: UUID,
        contents: [String]
    ) {
        self.id = id
        self.$device.id = device
        self.contents = contents
    }
}
