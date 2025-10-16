//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent

struct CreateContact: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.contact)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(ContactField.contactContents, .string, .required)
            .field(ContactField.askEmail, .string, .required)
            .field(CommonField.created_at, .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.contact).delete()
    }
}
