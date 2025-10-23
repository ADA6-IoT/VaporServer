//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

/// 환자 조회 프로토콜
protocol PatientRepositoryProtocol {
    /// 전체 환자 조회
    /// GET /api/patients/all
    func findAll() async throws -> [Patient]
    
    /// 층별/병동별 환자 조회
    /// GET /api/patients/floor/{floor}
    func findByFloor(_ floor: Int) async throws -> [Patient]
    
    /// 환자 검색
    /// GET /api/patients/search
    /// - Parameter keyword: 검색어
    /// - 문자열 입력 시: 환자 이름 기준 검색
    /// - 숫자 입력 시: 병동 번호 기준 검색
    func patientSearch(keyword: String) async throws -> [Patient]
   
    /// 환자 ID로 조회
    func findById(_ id: UUID) async throws -> Patient?
    
    /// 환자 생성
    /// POST /api/patient/add
    func create(_ patient: Patient) async throws -> Patient
    
    /// 환자 수정
    /// PUT /api/patients/{patientID}
    func update(_ patient: Patient) async throws -> Patient
    
    /// 환자 삭제
    /// DELETE /api/patients/{patientId}
    func delete(id: UUID) async throws
    
}
