//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/22/25.
//

import Vapor
import Fluent

protocol DeviceReportRepositoryProtocol {
    
    /// 여러 기기 신고 생성
    /// POST /api/devices/reports
    func createReports(_ reports: [DeviceReport]) async throws -> [DeviceReport]
    
    /// 특정 기기의 신고 내역 조회
    func findByDeviceSerialNumber(_ serialNumber: String) async throws -> [DeviceReport]
    
    /// 모든 신고 내역 조회
    func findAll() async throws -> [DeviceReport]
    
    /// 단일 신고 생성
    func create(_ report: DeviceReport) async throws -> DeviceReport
}
