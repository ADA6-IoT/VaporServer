//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent

struct CreateDevice: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.device)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(DeviceField.deviceName, .string, .required)
            .field(DeviceField.batteryLevel, .int, .required)
            .field(DeviceField.signalLevel, .int, .required)
            .field(DeviceField.malfunctionStatus, .bool, .required)
            .field(DeviceField.isAssigned, .bool, .required)
            .field(CommonField.created_at, .datetime)
            .field(CommonField.updated_at, .data)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.device).delete()
    }
}
