//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 환자 정보 부분 수정을 위한 요청 DTO
/// - name, ward, bed, departmentId, deviceSerial, memo는 모두 선택적(Optional)로 제공됩니다.
///   제공된 필드만 서버에서 수정됩니다.
struct PatientRevisionRequestDTO: Content {
    /// 환자 이름 (선택)
    let name: String?
    /// 병동 번호 (선택)
    let ward: Int?
    /// 병상 번호 (선택)
    let bed: Int?
    /// 소속 진료과 ID (선택)
    let departmentId: String?
    /// 연결된 디바이스 일련번호 (선택)
    let deviceSerial: String?
    /// 비고/메모 (선택)
    let memo: String?
}

/// 환자 정보 수정 결과를 반환하는 응답 DTO
/// 서버에서 최신 상태로 반영된 환자 정보를 포함합니다.
struct PatientRevisionResponseDTO: Content {
    /// 환자 고유 식별자
    let patientId: Int
    /// 환자 이름
    let name: String
    /// 소속 진료과 ID
    let departmentId: String
    /// 현재 위치 정보 (예: 병동/병상 등)
    let currentLocation: Location
    /// 연결된 디바이스 일련번호
    let deviceSerial: String
    /// 비고/메모
    let memo: String
}
