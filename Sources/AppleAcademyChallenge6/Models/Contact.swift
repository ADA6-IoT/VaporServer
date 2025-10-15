//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Contact: Model, Content, @unchecked Sendable {
    static let schema: String = "contact"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "contact_contents")
    var content: String
    
    @Field(key: "ask_email")
    var askEmail: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Children(for: \.$contact)
    var imageMappings: [ImageMapping]
    
    init() {}
    
    init(
        id: UUID? = nil,
        hospitalID: UUID,
        content: String,
        askEmail: String
    ) {
        self.id = id
        self.$hospital.id = hospitalID
        self.content = content
        self.askEmail = askEmail
    }
}
