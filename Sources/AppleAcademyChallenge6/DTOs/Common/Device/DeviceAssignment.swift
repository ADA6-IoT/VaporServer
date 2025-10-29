//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DeviceAssignment: Content {
    let patientId: String
    let patientName: String
    let ward: String
    let bed: String
    let department: String
    let assignedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case patientName = "patient_name"
        case ward
        case bed
        case department
        case assignedAt = "assigned_at"
    }
}
