//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Ward: Model, Content, @unchecked Sendable {
    static let schema: String = "ward"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "ward_number")
    var wardNumber: Int
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Children(for: \.$ward)
    var patients: [Patient]
    
    init() {}
    
    init(
        id: UUID? = nil,
        wardNumber: Int,
        hospital: UUID
    ) {
        self.id = id
        self.wardNumber = wardNumber
        self.$hospital.id = hospital
    }
}
