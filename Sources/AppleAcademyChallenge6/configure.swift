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
import SotoS3

public func configure(_ app: Application) async throws {
    try DatabaseConfiguration.configure(app)
    try await JWTConfiguration.configure(app)
    MigrationConfiguration.configure(app)
    app.s3 = S3Service(app: app)
    
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
    static let S3Key: String = "AWS_ACCESS_KEY_ID"
    static let S3AccessKey: String = "AWS_SECRET_ACCESS_KEY"
    static let S3Bucket: String = "AWS_S3_BUCKET"
}
