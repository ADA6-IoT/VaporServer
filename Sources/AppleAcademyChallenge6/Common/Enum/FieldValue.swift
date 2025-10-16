//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Foundation
import Fluent

enum HospitalAccountField {
    static let loginId: FieldKey = "hospital_login_id"
    static let pwd: FieldKey = "hospital_password"
    static let hospitalName: FieldKey = "hospital_name"
}

enum HospitalAccountTokenField {
    static let accessToken: FieldKey = "access_token"
    static let refreshToekn: FieldKey = "refresh_token"
    static let tokenExpires: FieldKey = "token_expires_at"
}

enum PatientField {
    static let patientName: FieldKey = "patients_name"
    static let patientEtc: FieldKey = "patients_etc"
    static let serialNumber: FieldKey = "serial_number"
}

enum BedField {
    static let bedNumber: FieldKey = "bed_number"
}

enum ContactField {
    static let contactContents: FieldKey = "contact_contents"
    static let askEmail: FieldKey = "ask_email"
}

enum DepartmentField {
    static let departmentName: FieldKey = "department_name"
}

enum DeviceField {
    static let deviceName: FieldKey = "device_name"
    static let batteryLevel: FieldKey = "battery_level"
    static let signalLevel: FieldKey = "signal_level"
    static let malfunctionStatus: FieldKey = "malfunction_status"
    static let isAssigned: FieldKey = "is_assigned"
}

enum DeviceReportField {
    static let serialNumber: FieldKey = "serial_number"
    static let reportingContents: FieldKey = "reporting_contents"
}

enum ImageField {
    static let imageUrl: FieldKey = "image_url"
    static let image_type: FieldKey = "image_type"
}

enum ImageMappingField {
    static let targetType: FieldKey = "target_type"
}

enum LocationField {
    static let latitude: FieldKey = "latitude"
    static let longitude: FieldKey = "longitude"
}

enum PatientsField {
    static let patientName: FieldKey = "patient_name"
    static let patientEtc: FieldKey = "patient_etc"
}

enum ReportField {
    static let reportContents: FieldKey = "report_contents"
}

enum WardField {
    static let wardNumber: FieldKey = "ward_number"
}
