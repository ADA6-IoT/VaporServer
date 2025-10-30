//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

// MARK: - Request

struct LoginRequest: Content {
    let email: String
    /// 비밀번호(평문으로 전송, 서버에서 bycrypt로 해싱)
    let password: String
}

// MARK: - Response

struct LoginResponseDTO: Content {
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
