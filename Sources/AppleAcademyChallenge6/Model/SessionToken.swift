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
    
    init(hospital: HospitalAccount) throws {
        guard let id = hospital.id else {
            throw Abort(.internalServerError, reason: "병원 계정 존재하지 않음")
        }
        
        self.hospitalId = id
        
        let expirationSeconds = Environment.jwtExpriationSeconds
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(expirationSeconds))
    }
    
    func verify(using algorithm: some JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }
}
