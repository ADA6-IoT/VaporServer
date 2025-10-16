//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent

/// 병동 테이블 생성 마이그레이션
struct CreateWard: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.ward)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(WardField.wardNumber, .int, .required)
            .field(CommonField.created_at, .datetime)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.ward).delete()
    }
}
