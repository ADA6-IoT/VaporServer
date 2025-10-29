//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 토큰 갱신 시 반환되는 응답 데이터 형식
struct ReissueResponse: Content {
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
}
