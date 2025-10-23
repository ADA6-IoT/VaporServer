//
//  DeviceRepository.swift
//  AppleAcademyChallenge6
//
//  Created by Claude on 10/22/25.
//

import Vapor
import Fluent

final class DeviceRepository: DeviceRepositoryProtocol {
    
    private let database: any Database
    
    init(database: any Database) {
        self.database = database
    }
    
    func findAll() async throws -> [Device] {
    }
    
    func findRegistered() async throws -> [Device] {
        <#code#>
    }
    
    func search(keyword: String) async throws -> [Device] {
        <#code#>
    }
    
    func findBySerialNumber(_ serialNumber: String) async throws -> Device? {
        <#code#>
    }
    
    func updateLocation(serialNumber: String, location: String) async throws -> Device {
        <#code#>
    }
    
    func create(_ device: Device) async throws -> Device {
        <#code#>
    }
    
    func update(_ device: Device) async throws -> Device {
        <#code#>
    }
}
