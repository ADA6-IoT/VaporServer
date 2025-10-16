//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent
import FluentSQL

struct CreateHospitalAccountToken: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.hospitalAccountToken)
            .id()
            .field(HospitalAccountTokenField.accessToken, .string, .required)
            .field(HospitalAccountTokenField.refreshToekn, .string, .required)
            .field(HospitalAccountTokenField.tokenExpires, .datetime, .required)
            .field(CommonField.created_at, .datetime)
            .field(CommonField.updated_at, .datetime)
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .unique(on: CommonIdField.hospitalId)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.hospitalAccountToken).delete()
    }
}
