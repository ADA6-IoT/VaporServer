//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent

struct CreateLocation: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.location)
            .id()
            .field(LocationField.latitude, .double, .required)
            .field(LocationField.longitude, .double, .required)
            .field(CommonField.updated_at, .datetime)
            .field(CommonIdField.patientsId, .uuid, .required, .references(SchemaValue.patients, .id, onDelete: .cascade))
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.location).delete()
    }
}
