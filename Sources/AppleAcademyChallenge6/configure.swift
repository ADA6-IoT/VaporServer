//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor
import Fluent
import FluentPostgresDriver
import JWT

public func configure(_ app: Application) async throws {
    try DatabaseConfiguration.configure(app)
    try await JWTConfiguration.configure(app)
    MigrationConfiguration.configure(app)
    
    // MARK: - Run
    try routes(app)
    try await MigrationConfiguration.migrate(app)
}

enum EnvironmentValue {
    static let host: String = "DATABASE_HOST"
    static let port: String = "DATABASE_PORT"
    static let username: String = "DATABASE_USERNAME"
    static let password: String = "DATABASE_PASSWORD"
    static let databaseName: String = "DATABASE_NAME"
    static let jwtSecret: String = "JWT_SECRET"
}
