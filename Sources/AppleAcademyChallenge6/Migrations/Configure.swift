//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
    let hostname = Environment.get(EnvironmentValue.host) ?? "localhost"
    let port = Environment.get(EnvironmentValue.port).flatMap(Int.init(_:)) ?? 5432
    let username = Environment.get(EnvironmentValue.username) ?? "postgres"
    let password = Environment.get(EnvironmentValue.password) ?? "password"
    let databaseName = Environment.get(EnvironmentValue.databaseName) ?? "hospital_db"
    
    let configuration = SQLPostgresConfiguration(
        hostname: hostname,
        port: port,
        username: username,
        password: password,
        database: databaseName,
        tls: .disable
    )
    
    app.databases.use(.postgres(configuration: configuration), as: .psql)
    MigrationRepository.register(on: app)
    
    try routes(app)
    try app.autoMigrate().wait()
}

enum EnvironmentValue {
    static let host: String = "DATABASE_HOST"
    static let port: String = "DATABASE_PORT"
    static let username: String = "DATABASE_USERNAME"
    static let password: String = "DATABASE_PASSWORD"
    static let databaseName: String = "DATABASE_NAME"
}
