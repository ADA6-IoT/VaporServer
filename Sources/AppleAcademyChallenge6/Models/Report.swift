//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Report: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.report
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @Field(key: ReportField.reportContents)
    var contents: String
    
    @Timestamp(key: CommonField.created_at, on: .create)
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
