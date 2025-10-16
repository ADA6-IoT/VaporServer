//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent

struct CreateDepartment: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.departments)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(DepartmentField.departmentName, .string, .required)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.departments).delete()
    }
}
