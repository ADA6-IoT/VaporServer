//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent

struct CreateImage: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.image)
            .id()
            .field(ImageField.imageUrl, .string, .required)
            .field(ImageField.image_type, .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.image).delete()
    }
}
