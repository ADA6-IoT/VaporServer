//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

protocol DepartmentRepositoryProtocol {
    /// 소속과 조회
    /// GET /api/departments/all
    func findAll() async throws -> [Department]
    
    /// 소속과 ID로 조회
    func findById(_ id: UUID) async throws -> Department?
    
    /// 소속과 이름으로 조회
    func findByName(_ name: String) async throws -> Department?
    
    /// 소속과 생성
    /// POST /api/departments/add
    func create(_ department: Department) async throws -> Department
    
    /// 소속과 수정
    func update(_ department: Department) async throws -> Department
    
    /// 소속과 삭제
    func delete(id: UUID) async throws
}
