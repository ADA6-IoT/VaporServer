//
//  DatabaseConfig.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Fluent
import FluentPostgresDriver
import Vapor

enum DatabaseConfig {
    static func configure(_ app: Application) throws {
        try configureDatabase(app)
        registerMigrations(app)
    }
}

private extension DatabaseConfig {
    static func configureDatabase(_ app: Application) throws {
        let hostname = Environment.get("DATABASE_HOST") ?? "localhost"
        let port = Environment.get("DATABASE_PORT").flatMap(Int.init) ?? PostgresConfiguration.ianaPortNumber
        let username = Environment.get("DATABASE_USERNAME") ?? "postgres"
        let password = Environment.get("DATABASE_PASSWORD") ?? "postgres"
        let database = Environment.get("DATABASE_NAME") ?? "apple_academy_challenge_6"

        app.databases.use(
            .postgres(
                configuration: .init(
                    hostname: hostname,
                    port: port,
                    username: username,
                    password: password,
                    database: database,
                    tls: .disable
                )
            ),
            as: .psql
        )
    }

    static func registerMigrations(_ app: Application) {
        app.migrations.add(CreateHospitalAccount())
        app.migrations.add(CreateHospitalAccountToken())
        app.migrations.add(CreateWard())
        app.migrations.add(CreateBed())
        app.migrations.add(CreateDepartment())
        app.migrations.add(CreateDevice())
        app.migrations.add(CreateDeviceReport())
        app.migrations.add(CreatePatient())
        app.migrations.add(CreateLocation())
        app.migrations.add(CreateContact())
        app.migrations.add(CreateReport())
        app.migrations.add(CreateImage())
        app.migrations.add(CreateImageMapping())
    }
}
