//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class HospitalAccountToken: Model, Content, @unchecked Sendable {
    static let schema: String = "hospital_account_token"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "access_token")
    var accessToken: String
    
    @Field(key: "refresh_token")
    var refreshToken: String
    
    @Field(key: "token_expires_at")
    var tokenExpiresAt: Date
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        hospitalID: UUID,
        accessToken: String,
        refreshToken: String,
        tokenExpiresAt: Date
    ) {
        self.id = id
        self.$hospital.id = hospitalID
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenExpiresAt = tokenExpiresAt
    }
}
