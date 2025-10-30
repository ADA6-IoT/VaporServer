//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

// MARK:  - Response

struct TokenResponseDTO: Content {
    let accessToken: String
    let expiresAt: Date
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
    }
}
