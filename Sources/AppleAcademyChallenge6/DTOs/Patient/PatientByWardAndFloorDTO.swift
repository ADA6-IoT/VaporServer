//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 병동별 환자 조회 요청 파라미터 DTO
/// - Note: `ward`는 병동(병실 구역)을 나타내는 정수 식별자입니다.
struct PatientByWardAndFloorQueryDTO: Content {
    /// 조회할 병동 식별자
    let ward: Int?
}

/// 병동/층 기준 환자 목록 응답 DTO
/// 서버에서 환자 기본 정보와 배정된 병동/침상 정보를 내려줍니다.
struct PatientByWardAndFloorParameterResponseDTO: Content {
    /// 환자 고유 식별자
    let patientId: Int
    /// 환자명
    let name: String
    /// 진료과 명칭 (예: 내과, 외과)
    let departmentName: String
    /// 환자에게 배정된 디바이스 시리얼 번호
    let deviceSerial: String
    /// 배정된 병동(예: "A-3병동")
    let ward: Int
    /// 배정된 침상 번호(예: "12-1")
    let bed: Int
}
