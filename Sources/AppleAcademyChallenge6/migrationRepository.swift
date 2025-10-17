//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

enum MigrationRepository {
    static func register(on app: Application) {
        AuthMigrations.register(on: app)
        PatientMigrations.register(on: app)
        DeviceMigrations.register(on: app)
        ReportMigrations.register(on: app)
        ImageMigrations.register(on: app)
    }
}
