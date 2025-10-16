//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class HospitalAccount: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.hospitalAccount

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: HospitalAccountField.loginId)
    var hospitalLoginId: String
    
    @Field(key: HospitalAccountField.pwd)
    var hospitalPassword: String
    
    @Field(key: HospitalAccountField.hospitalName)
    var hospitalName: String
    
    @Timestamp(key: CommonField.created_at, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: CommonField.updated_at, on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$hospital)
    var patients: [Patient]
    
    @Children(for: \.$hospital)
    var wards: [Ward]
    
    @Children(for: \.$hospital)
    var devices: [Device]
    
    @OptionalChild(for: \.$hospital)
    var hospitalToken: HospitalAccountToken?
    
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
