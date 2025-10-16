//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Fluent
import FluentSQL

/// 병원 계정 마이그레이션
struct CreateHospitalAccount: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema(SchemaValue.hospitalAccount)
            .id()
            .field(HospitalAccountField.loginId, .string, .required)
            .field(HospitalAccountField.pwd, .string, .required)
            .field(HospitalAccountField.hospitalName, .string, .required)
            .field(CommonField.created_at, .datetime)
            .field(CommonField.updated_at, .datetime)
            .unique(on: HospitalAccountField.loginId)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema(SchemaValue.hospitalAccount).delete()
    }
}
