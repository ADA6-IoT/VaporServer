//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

// MARK: - Reuquest

struct RegisterRequestDTO: Content {
    let email: String
    let password: String
    let hospitalName: String
    let businessNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password
        case hospitalName = "hospital_name"
        case businessNumber = "business_number"
    }
    
    func validate() throws {
        guard email.contains("@") else {
            throw Abort(.badRequest, reason: "Invalid email format")
        }
        
        guard password.count >= 8 else {
            throw Abort(.badRequest, reason: "Password must be at least 8 characters")
        }
        
        guard !hospitalName.isEmpty else {
            throw Abort(.badRequest, reason: "Hospital name is required")
        }
    }
}


struct AuthResponseDTO: Content {
    let hospital: HospitalDTO
    let accessToken: String
    let refreshToken: String
    let tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case hospital
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
    
    init(
        hospital: HospitalDTO,
        accessToken: String,
        refreshToken: String,
        expiresIn: Int
    ) {
        self.hospital = hospital
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.tokenType = "Bearer"
        self.expiresIn = expiresIn
    }
}

