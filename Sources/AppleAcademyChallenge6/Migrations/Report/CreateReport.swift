//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent

struct CreateReport: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.report)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(ReportField.reportContents, .string, .required)
            .field(CommonField.created_at, .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.report).delete()
    }
}
