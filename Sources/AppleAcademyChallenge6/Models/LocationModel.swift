//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Vapor
import Fluent

final class LocationModel: Model, Content, @unchecked Sendable {
    static let schema: String = "location"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "latitude")
    var latitude: Double
    
    @Field(key: "longitude")
    var longitude: Double
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Parent(key: "patients_id")
    var patient: Patient
    
    init() {}
    
    init(
        id: UUID? = nil,
        latitude: Double,
        logitude: Double,
        patient: UUID,
        hospital: UUID
    ) {
        self.id = id
        self.latitude = latitude
        self.longitude = logitude
        self.updatedAt = updatedAt
        self.$patient.id = patient
    }
}
