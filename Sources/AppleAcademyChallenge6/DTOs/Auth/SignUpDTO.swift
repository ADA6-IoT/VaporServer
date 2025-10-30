//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

// MARK: - Reuquest

struct SignUpRequest: Content {
    let email: String
    let password: String
    let name: String
    let businessNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password, name
        case businessNumber = "business_number"
    }
}

struct SignupResponseDTO: Content {
    let accessToken: String
    let expiresAt: Date
    let expiresIn: Int           
    let hospital: HospitalDTO
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
        case hospital
    }
}
