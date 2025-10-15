//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Report: Model, Content, @unchecked Sendable {
    static let schema: String = "report"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "report_contents")
    var contents: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Children(for: \.$report)
    var imageMappings: [ImageMapping]
    
    init() { }
    
    init(id: UUID? = nil, hospitalId: UUID, contents: String) {
        self.id = id
        self.$hospital.id = hospitalId
        self.contents = contents
    }
}
