//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/31/25.
//

import Fluent
import Vapor
import FluentPostgresDriver

struct DatabaseConfiguration {
    static func configure(_ app: Application) throws {
        let hostname = Environment.get(EnvironmentValue.host) ?? "localhost"
        let port = Environment.get(EnvironmentValue.port).flatMap(Int.init(_:)) ?? 5432
        let username = Environment.get(EnvironmentValue.username) ?? "postgres"
        let password = Environment.get(EnvironmentValue.password) ?? "password"
        let databaseName = Environment.get(EnvironmentValue.databaseName) ?? "FindU_db"
        
        let configuration = SQLPostgresConfiguration(
            hostname: hostname,
            port: port,
            username: username,
            password: password,
            database: databaseName,
            tls: .disable
        )
        
        app.databases.use(.postgres(configuration: configuration), as: .psql)
    }
}
