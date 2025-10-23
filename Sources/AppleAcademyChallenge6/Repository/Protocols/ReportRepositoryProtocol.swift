//
//  ReportRepositoryProtocol.swift
//  AppleAcademyChallenge6
//
//  Created by Claude on 10/22/25.
//

import Vapor
import Fluent

protocol ReportRepositoryProtocol {
    /// 병원 앱 신고 생성
    /// POST /api/app/report
    func create(_ report: Report) async throws -> Report
    
    /// 모든 신고 조회
    func findAll() async throws -> [Report]
    
    /// 특정 병원의 신고 조회
    func findByHospitalId(_ hospitalId: UUID) async throws -> [Report]
    
    /// 신고 ID로 조회
    func findById(_ id: UUID) async throws -> Report?
    
    /// 신고 삭제
    func delete(id: UUID) async throws
}
