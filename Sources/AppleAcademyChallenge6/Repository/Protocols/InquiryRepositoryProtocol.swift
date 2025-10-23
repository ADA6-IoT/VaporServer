//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

protocol InquiryRepositoryProtocol {
    /// 병원 앱 문의 생성
    /// POST /api/app/inquiry
    func create(_ inquiry: Contact) async throws -> Contact
    /// 모든 문의 조회
    func fincAll() async throws -> [Contact]
    /// 특정 병원의 문의 조회
    func findByHospitalId(_ hospitalId: UUID) async throws -> [Contact]
    /// 문의 ID로 조회
    func findById(_ id: UUID) async throws -> Contact?
    /// 문의 삭제
    func delete(id: UUID) async throws
}
