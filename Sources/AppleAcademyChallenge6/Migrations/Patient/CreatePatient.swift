//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Fluent

struct CreatePatient: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.patients)
            .id()
            .field(CommonIdField.hospitalId, .uuid, .required, .references(SchemaValue.hospitalAccount, .id, onDelete: .cascade))
            .field(PatientField.patientName, .string, .required)
            .field(PatientField.patientEtc, .string, .required)
            .field(CommonField.created_at, .datetime)
            .field(CommonField.updated_at, .datetime)
            .field(PatientField.serialNumber, .uuid, .references(SchemaValue.device, .id, onDelete: .setNull))
            .field(CommonIdField.wardId, .uuid, .references(SchemaValue.ward, .id, onDelete: .setNull))
            .field(CommonIdField.bedId, .uuid, .references(SchemaValue.bed, .id, onDelete: .setNull))
            .field(CommonIdField.departmentId, .uuid, .references(SchemaValue.departments, .id, onDelete: .setNull))
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.patients).delete()
    }
}
