//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Vapor
import Fluent

final class Department: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.departments
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @Field(key: DepartmentField.departmentName)
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
