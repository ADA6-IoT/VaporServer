//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Device: Model, Content, @unchecked Sendable {
    static let schema: String = "device"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @Field(key: "device_name")
    var name: String
    
    @Field(key: "battery_level")
    var batteryLevel: Int
    
    @Field(key: "signal_level")
    var signalLevel: Int
    
    @Field(key: "malfunction_status")
    var isMalfunctioning: Bool
    
    @Field(key: "is_assigned")
    var isAssigned: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
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
