//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent

/// 이미지 매핑(ImageMapping) 테이블 생성 마이그레이션
struct CreateImageMapping: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.imageMapping)
            .id()
            .field(CommonIdField.photoId, .uuid, .required, .references(SchemaValue.image, .id, onDelete: .cascade))
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(CommonIdField.contactId, .uuid, .references(SchemaValue.contact, .id, onDelete: .setNull))
            .field(CommonIdField.reportId, .uuid, .references(SchemaValue.report, .id, onDelete: .setNull))
            .field(ImageMappingField.targetType, .string, .required)
            .field(CommonIdField.targetId, .uuid, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.imageMapping).delete()
    }
}
