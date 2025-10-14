//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 토큰 갱신 시 반환되는 응답 데이터 형식
struct TokenResponseDTO: Content {
    let accessToken: String
    let refreshToken: String
}
