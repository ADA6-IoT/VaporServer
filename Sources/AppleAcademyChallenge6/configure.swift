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
    // MARK: - Middleware Configuration

    // 1. 에러 처리 미들웨어 (모든 에러를 캐치하고 적절한 응답 반환)
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    // 2. 정적 파일 제공 미들웨어
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // 3. 요청 로깅 미들웨어 (개발/프로덕션 환경에서 요청 로그 출력)
    app.middleware.use(RouteLoggingMiddleware(logLevel: .info))

    // 4. CORS 설정 미들웨어
    CORSConfiguration.configure(app)

    // 5. DI 컨테이너 미들웨어
    app.middleware.use(DIMiddleware())

    // MARK: - Configuration
    try DatabaseConfiguration.configure(app)
    try await JWTConfiguration.configure(app)
    MigrationConfiguration.configure(app)
    app.s3 = S3Service(app: app)
    
    // MARK: - Run
    try routes(app)
    
    app.get("openapi") { req -> Response in
        let openapi = OpenAPIConfiguration.generateOpenAPI(for: req.application)
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let data = try encoder.encode(openapi)
        
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return Response(status: .ok, headers: headers, body: .init(data: data))
    }
    
    
    try await MigrationConfiguration.migrate(app)
}

enum EnvironmentValue {
    static let host: String = "DATABASE_HOST"
    static let port: String = "DATABASE_PORT"
    static let username: String = "DATABASE_USERNAME"
    static let password: String = "DATABASE_PASSWORD"
    static let databaseName: String = "DATABASE_NAME"
    static let jwtSecret: String = "JWT_SECRET"
    static let jwtExpirationSeconds: String = "JWT_EXPIRATION_SECONDS"
    static let S3Key: String = "AWS_ACCESS_KEY_ID"
    static let S3AccessKey: String = "AWS_SECRET_ACCESS_KEY"
    static let S3Bucket: String = "AWS_S3_BUCKET"
    static let serverUrl: String = "SERVER_URL"
}
