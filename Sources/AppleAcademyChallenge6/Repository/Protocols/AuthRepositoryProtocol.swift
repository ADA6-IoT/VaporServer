//
//  AuthRepositoryProtocol.swift
//  AppleAcademyChallenge6
//
//  Created by Claude on 10/22/25.
//

import Vapor
import Fluent

protocol AuthRepositoryProtocol {
    /// 로그인 - 로그인 ID로 병원 조회
    /// POST /api/auth/login
    func findByLoginId(_ loginId: String) async throws -> HospitalAccount?
    
    /// 병원 계정 토큰 생성
    func createToken(for hospital: HospitalAccount, accessToken: String, refreshToken: String, expiresAt: Date) async throws -> HospitalAccountToken
    
    /// 병원 계정 토큰 조회 (병원 ID로)
    func findToken(byHospitalId hospitalId: UUID) async throws -> HospitalAccountToken?
    
    /// 병원 계정 토큰 조회 (Refresh Token으로)
    func findToken(byRefreshToken refreshToken: String) async throws -> HospitalAccountToken?
    
    /// 병원 계정 토큰 업데이트 (토큰 갱신)
    /// GET /api/auth/reissue
    func updateToken(_ token: HospitalAccountToken) async throws -> HospitalAccountToken
    
    /// 병원 계정 토큰 삭제 (로그아웃)
    func deleteToken(hospitalId: UUID) async throws
    
    /// 만료된 토큰 삭제
    func deleteExpiredTokens() async throws
}
