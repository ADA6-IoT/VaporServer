//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Bed: Model, Content, @unchecked Sendable {
    static let schema: String = "beds"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "ward_id")
    var ward: Ward
    
    @Field(key: "bed_number")
    var bedNumber: Int
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    init() {}
    
    init(
        id: UUID? = nil,
        ward: UUID,
        bedNumber: Int
    ) {
        self.id = id
        self.$ward.id = ward
        self.bedNumber = bedNumber
    }
}
