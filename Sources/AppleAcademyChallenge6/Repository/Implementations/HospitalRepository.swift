//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

final class HospitalRepository: HospitalRepositoryProtocol {
    private let database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    func findById(_ id: UUID) async throws -> HospitalAccount? {
        try await HospitalAccount.find(id, on: database)
    }
    
    func findByLoginId(_ loginId: String) async throws -> HospitalAccount? {
        let result = try await HospitalAccount.query(on: database)
            .filter(\HospitalAccount.$hospitalLoginId == loginId)
            .all()
        return result.first
    }
    
    func create(_ hospital: HospitalAccount) async throws -> HospitalAccount {
        try await hospital.update(on: database)
        return hospital
    }
    
    func update(_ hospital: HospitalAccount) async throws -> HospitalAccount {
        try await hospital.update(on: database)
        return hospital
    }
    
    func delete(id: UUID) async throws {
        guard let hospital = try await HospitalAccount.find(id, on: database) else {
            throw Abort(.notFound, reason: "병원 존재 하지 않음")
        }
        try await hospital.delete(on: database)
    }
    
    func findAll() async throws -> [HospitalAccount] {
        try await HospitalAccount.query(on: database).all()
    }
    
    func findByName(_ name: String) async throws -> [HospitalAccount] {
        try await HospitalAccount.query(on: database)
            .filter(\HospitalAccount.$hospitalName ~~ name)
            .all()
    }
    
    
}
