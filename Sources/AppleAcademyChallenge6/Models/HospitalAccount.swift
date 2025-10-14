//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class HospitalAccount: Model, Content, @unchecked Sendable {
    static let schema = "hospital_account"

    @ID(custom: "account_id")
    var id: UUID?
    
    @Field(key: "hospital_login_id")
    var hospitalLoginId: String
    
    @Field(key: "hospital_password")
    var hospitalPassword: String
    
    @Field(key: "hospital_name")
    var hospitalName: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .create)
    var updatedAt: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        hospitalLoginId: String,
        hospitalPassword: String,
        hospitalName: String
    ) {
        self.id = id
        self.hospitalLoginId = hospitalLoginId
        self.hospitalPassword = hospitalPassword
        self.hospitalName = hospitalName
    }
}
