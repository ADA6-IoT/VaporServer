//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class HospitalAccountToken: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.hospitalAccountToken
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @Field(key: HospitalAccountTokenField.accessToken)
    var accessToken: String
    
    @Field(key: HospitalAccountTokenField.refreshToekn)
    var refreshToken: String
    
    @Field(key: HospitalAccountTokenField.tokenExpires)
    var tokenExpiresAt: Date
    
    @Timestamp(key: CommonField.created_at, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: CommonField.updated_at, on: .update)
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
