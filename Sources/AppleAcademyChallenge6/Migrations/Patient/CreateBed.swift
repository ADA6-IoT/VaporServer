//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent
import Vapor

struct CreateBed: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.bed)
            .id()
            .field(CommonIdField.wardId, .uuid, .required, .references(SchemaValue.ward, .id, onDelete: .cascade))
            .field(BedField.bedNumber, .int, .required)
            .field(CommonField.created_at, .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.bed).delete()
    }
}
