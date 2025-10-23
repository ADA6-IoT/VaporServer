//
//  HospitalRepositoryProtocol.swift
//  AppleAcademyChallenge6
//
//  Created by Claude on 10/22/25.
//

import Vapor
import Fluent

protocol HospitalRepositoryProtocol {
    /// 병원 ID로 조회
    func findById(_ id: UUID) async throws -> HospitalAccount?
    
    /// 병원 로그인 ID로 조회
    func findByLoginId(_ loginId: String) async throws -> HospitalAccount?
    
    /// 병원 생성 (회원가입)
    /// POST /api/app/signup
    func create(_ hospital: HospitalAccount) async throws -> HospitalAccount
    
    /// 병원 정보 수정
    func update(_ hospital: HospitalAccount) async throws -> HospitalAccount
    
    /// 병원 삭제
    /// DELETE /api/app/delete
    func delete(id: UUID) async throws
    
    /// 모든 병원 조회
    func findAll() async throws -> [HospitalAccount]
    
    /// 병원 이름으로 검색
    func findByName(_ name: String) async throws -> [HospitalAccount]
}
