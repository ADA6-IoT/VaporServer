//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Foundation
import Fluent

enum CommonField {
    static let created_at: FieldKey = "created_at"
    static let updated_at: FieldKey = "updated_at"
}

enum CommonIdField {
    static let hospitalId: FieldKey = "hospital_id"
    static let wardId: FieldKey = "ward_id"
    static let bedId: FieldKey = "bed_id"
    static let departmentId: FieldKey = "department_id"
    static let photoId: FieldKey = "photo_id"
    static let contactId: FieldKey = "contact_id"
    static let reportId: FieldKey = "report_id"
    static let targetId: FieldKey = "target_id"
    static let patientsId: FieldKey = "patients_id"
}
