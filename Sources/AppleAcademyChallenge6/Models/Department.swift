//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Vapor
import Fluent

final class Department: Model, Content, @unchecked Sendable {
    static let schema: String = "departments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "department_name")
    var name: String
    
    @Children(for: \.$department)
    var patients: [Patient]
    
    init() {}
    
    init(
        hospital: UUID,
        name: String
    ) {
        self.$hospital.id = hospital
        self.name = name
    }
}
