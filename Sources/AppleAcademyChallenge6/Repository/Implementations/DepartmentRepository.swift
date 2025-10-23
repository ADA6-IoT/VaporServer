//
//  DepartmentRepository.swift
//  AppleAcademyChallenge6
//
//  Created by Claude on 10/22/25.
//

import Vapor
import Fluent

final class DepartmentRepository: DepartmentRepositoryProtocol {
    private let database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    func findAll() async throws -> [Department] {
        try await Department.query(on: database).all()
    }
    
    func findById(_ id: UUID) async throws -> Department? {
        try await Department.find(id, on: database)
    }
    
    func findByName(_ name: String) async throws -> Department? {
        let results = try await Department.query(on: database)
            .filter(\.$name == name)
            .all()
        return results.first
    }
    
    func create(_ department: Department) async throws -> Department {
        try await department.create(on: database)
        return department
    }
    
    func update(_ department: Department) async throws -> Department {
        try await department.update(on: database)
        return department
    }
    
    func delete(id: UUID) async throws {
        guard let department = try await Department.find(id, on: database) else {
            throw Abort(.notFound, reason: "Department not found")
        }
        try await department.delete(on: database)
    }
}
