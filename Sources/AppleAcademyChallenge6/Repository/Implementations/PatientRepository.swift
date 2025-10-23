//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

final class PatientRepository: PatientRepositoryProtocol {
    
    private let database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    func findAll() async throws -> [Patient] {
        try await Patient.query(on: database).all()
    }
    
    func findByFloor(_ floor: Int) async throws -> [Patient] {
        try await Patient.query(on: database)
            .join(Ward.self, on: \Patient.$ward.$id == \Ward.$id)
            .filter(Ward.self, \Ward.$wardNumber == floor)
            .all()
    }
    
    func patientSearch(keyword: String) async throws -> [Patient] {
        if let wardNumber = Int(keyword) {
            return try await Patient.query(on: database)
                .join(Ward.self, on: \Patient.$ward.$id == \Ward.$id)
                .filter(Ward.self, \Ward.$wardNumber == wardNumber)
                .all()
        } else {
            return try await Patient.query(on: database)
                .filter(\Patient.$name ~~ keyword)
                .all()
        }
    }
    
    func findById(_ id: UUID) async throws -> Patient? {
        try await Patient.find(id, on: database)
    }
    
    func create(_ patient: Patient) async throws -> Patient {
        try await patient.create(on: database)
        return patient
    }
    
    func update(_ patient: Patient) async throws -> Patient {
        try await patient.update(on: database)
        return patient
    }
    
    func delete(id: UUID) async throws {
        guard let patient = try await Patient.find(id, on: database) else {
            throw Abort(.notFound, reason: "환자 검색 실패")
        }
        try await patient.delete(on: database)
    }
}
