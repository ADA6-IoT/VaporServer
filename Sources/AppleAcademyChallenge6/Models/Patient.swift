//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Patient: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.patients
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @Field(key: PatientField.patientName)
    var name: String
    
    @Field(key: PatientField.patientEtc)
    var etc: String
    
    @Timestamp(key: CommonField.created_at, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: CommonField.updated_at, on: .update)
    var updatedAt: Date?
    
    @OptionalParent(key: PatientField.serialNumber)
    var device: Device?
    
    @OptionalParent(key: CommonIdField.wardId)
    var ward: Ward?
    
    @OptionalParent(key: CommonIdField.bedId)
    var bed: Bed?
    
    @OptionalParent(key: CommonIdField.departmentId)
    var department: Department?
    
    init() {}
    
    init(id: UUID? = nil, name: String, etc: String, serialNumber: String, hospitalID: UUID) {
        self.id = id
        self.name = name
        self.etc = etc
        self.$hospital.id = hospitalID
    }
}
