//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

final class AuthRepository: AuthRepositoryProtocol {
    
    private let database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    func findByLoginId(_ loginId: String) async throws -> HospitalAccount? {
        try await HospitalAccount.query(on: database)
            .filter(\HospitalAccount.$hospitalLoginId == loginId)
            .first()
    }
    
    func createToken(for hospital: HospitalAccount, accessToken: String, refreshToken: String, expiresAt: Date) async throws -> HospitalAccountToken {
        guard let hospitalId = hospital.id else {
            throw Abort(.internalServerError, reason: "병원 존재하지 않음")
        }
        
        let token = HospitalAccountToken(
            hospitalID: hospitalId,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenExpiresAt: expiresAt
        )
        
        try await token.create(on: database)
        return token
    }
    
    func findToken(byHospitalId hospitalId: UUID) async throws -> HospitalAccountToken? {
        try await HospitalAccountToken.query(on: database)
            .filter(\HospitalAccountToken.$id == hospitalId)
            .first()
    }
    
    func findToken(byRefreshToken refreshToken: String) async throws -> HospitalAccountToken? {
        try await HospitalAccountToken.query(on: database)
            .filter(\HospitalAccountToken.$refreshToken == refreshToken)
            .first()
    }
    
    func updateToken(_ token: HospitalAccountToken) async throws -> HospitalAccountToken {
        try await token.update(on: database)
        return token
    }
    
    func deleteToken(hospitalId: UUID) async throws {
        try await HospitalAccountToken.query(on: database)
            .filter(\HospitalAccountToken.$id == hospitalId)
            .delete()
    }
    
    func deleteExpiredTokens() async throws {
        try await HospitalAccountToken.query(on: database)
            .filter(\HospitalAccountToken.$tokenExpiresAt < Date())
            .delete()
    }
}
