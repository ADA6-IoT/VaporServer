//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Patient: Model, Content, @unchecked Sendable {
    static let schema: String = "patients"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "patients_name")
    var name: String
    
    @Field(key: "patients_etc")
    var etc: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @OptionalParent(key: "serial_number")
    var device: Device?
    
    @OptionalParent(key: "ward_id")
    var ward: Ward?
    
    @OptionalParent(key: "bed_id")
    var bed: Bed?
    
    @OptionalParent(key: "department_id")
    var department: Department?
    
    init() {}
    
    init(id: UUID? = nil, name: String, etc: String, serialNumber: String, hospitalID: UUID) {
        self.id = id
        self.name = name
        self.etc = etc
        self.$hospital.id = hospitalID
    }
}
