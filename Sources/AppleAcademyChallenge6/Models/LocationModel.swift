//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/15/25.
//

import Vapor
import Fluent

final class LocationModel: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.location
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: LocationField.latitude)
    var latitude: Double
    
    @Field(key: LocationField.longitude)
    var longitude: Double
    
    @Timestamp(key: CommonField.updated_at, on: .update)
    var updatedAt: Date?
    
    @Parent(key: CommonIdField.patientsId)
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
