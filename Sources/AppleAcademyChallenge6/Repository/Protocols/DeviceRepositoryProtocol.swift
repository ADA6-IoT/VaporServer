//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

protocol DeviceRepositoryProtocol {
    /// 기기 리스트 조회
    /// GET /api/devices/all
    func findAll() async throws -> [Device]
    
    /// 등록된 기기 조회
    /// GET /api/device/lookup
    func findRegistered() async throws -> [Device]
    
    /// 기기 검색
    /// GET /api/device/search
    func search(keyword: String) async throws -> [Device]
    
    /// Serial Number로 기기 조회
    func findBySerialNumber(_ serialNumber: String) async throws -> Device?
    
    /// 기기 위치 업데이트
    /// PATCH /api/devices/{serialNumber}/locatoin
    func updateLocation(serialNumber: String, location: String) async throws -> Device
    
    /// 기기 생성
    func create(_ device: Device) async throws -> Device
    
    /// 기기 수정
    func update(_ device: Device) async throws -> Device
}
