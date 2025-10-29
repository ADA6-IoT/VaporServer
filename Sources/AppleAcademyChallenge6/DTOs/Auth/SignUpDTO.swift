//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct SignUpRequest: Content {
    let hospitalId: String
    let hospitalPwd: String
    let hospitalName: String
    
    enum CodingKeys: String, CodingKey {
        case hospitalId = "hospital_id"
        case hospitalPwd = "hospital_pwd"
        case hospitalName = "hospital_name"
    }
}

struct SignUpResponse: Content {
    let id: UUID
    let hospitalId: String
    let hospitalName: String
    let createAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hospitalId = "hospital_id"
        case hospitalName = "hospital_name"
        case createAt = "created_at"
    }
}
