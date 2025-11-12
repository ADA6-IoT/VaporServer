//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/12/25.
//

import Vapor
import Fluent

final class AuthService: ServiceProtocol {
    var database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    // MARK: - 계정 생성
    func sigunup(
        email: String,
        password: String,
        name: String,
        businessNumber: String?
    ) async throws -> HospitalAccount {
        
        if let _ = try await HospitalAccount.query(on: database)
            .filter(\.$email == email)
            .first() {
            throw Abort(.conflict, reason: "이메일 이미 존재합니다")
        }
        
        let passworddHash = try Bcrypt.hash(password)
        
        let hospital = HospitalAccount(
            email: email,
            passwordHash: passworddHash,
            hospitalName: name,
            businessNumber: businessNumber
        )
        
        try await hospital.save(on: database)
        
        return hospital
    }
    
    // MARK: - 로그인
    
    func login(email: String, password: String) async throws -> HospitalAccount {
        guard let hospital = try await HospitalAccount.query(on: database)
            .filter(\.$email == email)
            .first() else {
            throw Abort(.unauthorized, reason: "유효하지 않은 이메일 및 패스워드 입니다")
        }
        
        guard try hospital.verify(password: password) else {
            throw Abort(.unauthorized, reason: "유효하지 않은 이메일 및 패스워드 입니다.")
        }
        
        return hospital
    }
    
    // MARK: - 토큰 재발급
    
    func reissueToken(hospitalId: UUID) async throws -> HospitalAccount {
        guard let hospital = try await HospitalAccount.find(hospitalId, on: database) else {
            throw Abort(.notFound, reason: "병원을 찾을 수 없습니다.")
        }
        
        return hospital
    }
    
    // MARK: - 계정삭제
    
    func deleteAccount(hospitalId: UUID) async throws {
        guard let hospital = try await HospitalAccount.find(hospitalId, on: database) else {
            throw Abort(.notFound, reason: "병원을 찾을 수 없습니다.")
        }
        
        try await hospital.delete(on: database)
    }
}

