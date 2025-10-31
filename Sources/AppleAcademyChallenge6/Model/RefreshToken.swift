//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/30/25.
//

import Vapor
import Fluent

final class RefreshToken: Model, Content, @unchecked Sendable {
    static let schema = SchemaValue.refreshToken
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "token")
    var token: String
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Timestamp(key: "expires_at", on: .none)
    var expiresAt: Date?
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        token: String,
        hospitalId: UUID,
        expiresAt: Date
    ) {
        self.id = id
        self.token = token
        self.$hospital.id = hospitalId
        self.expiresAt = expiresAt
    }
}
