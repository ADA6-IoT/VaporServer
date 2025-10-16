//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent

struct CreateDeviceReport: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.deviceReport)
            .id()
            .field(DeviceReportField.serialNumber, .uuid, .required, .references(SchemaValue.device, .id, onDelete: .cascade))
            .field(DeviceReportField.reportingContents, .array(of: .string), .required)
            .field(CommonField.created_at, .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.deviceReport).delete()
    }
}
