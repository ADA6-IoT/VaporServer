//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Device: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.device
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @Field(key: DeviceField.deviceName)
    var name: String
    
    @Field(key: DeviceField.batteryLevel)
    var batteryLevel: Int
    
    @Field(key: DeviceField.signalLevel)
    var signalLevel: Int
    
    @Field(key: DeviceField.malfunctionStatus)
    var isMalfunctioning: Bool
    
    @Field(key: DeviceField.isAssigned)
    var isAssigned: Bool
    
    @Timestamp(key: CommonField.created_at, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: CommonField.updated_at, on: .update)
    var updatedAt: Date?
    
    @Children(for: \.$device)
    var deviceReports: [DeviceReport]
    
    @OptionalChild(for: \.$device)
    var assignedPatient: Patient?
    
    init() {}
    
    init(
        id: UUID? = nil,
        name: String,
        batteryLevel: Int,
        signalLevel: Int,
        isMalfunctioning: Bool,
        isAssigned: Bool
    ) {
        self.id = id
        self.name = name
        self.batteryLevel = batteryLevel
        self.signalLevel = signalLevel
        self.isMalfunctioning = isMalfunctioning
        self.isAssigned = isAssigned
    }
    
}
