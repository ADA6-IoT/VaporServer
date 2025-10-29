//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/29/25.
//

import Vapor
import Fluent
import JWT

struct SessionToken: Content, Authenticatable, JWTPayload {
    var expiration: ExpirationClaim
    var hospitalId: UUID
    
    /// id 값만 알고 있을 떄 토큰을 생성
    /// - Parameter hospitalId: 아이디 값
    init(hospitalId: UUID) {
        self.hospitalId = hospitalId
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(60 * 60 * 24 * 7))
    }
    
    /// HospitalAccount 모델로부터 JWT 생성
    /// - Parameter hospital: 병원 모델
    init(hospital: HospitalAccount) throws {
        self.hospitalId = try hospital.requireID()
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(60 * 60 * 24 * 7))
    }
    
    /// 토큰 유효 검사
    /// - Parameter algorithm: 만료 검사 알고리즘
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }
}
