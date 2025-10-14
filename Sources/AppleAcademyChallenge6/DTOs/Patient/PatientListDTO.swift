//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 전체 환자 조회 시 사용하는 응답 DTO
/// - Note: Vapor `Content` 프로토콜을 채택하여 JSON 인코딩/디코딩에 사용됩니다.
struct PatientListResponseDTO: Content {
    /// 환자 고유 식별자
    let patientId: Int
    /// 환자 이름
    let name: String
    /// 소속 진료과 이름
    let departmentName: String
    /// 환자에게 연결된 디바이스(모니터 등) 시리얼 번호
    let deviceSerial: String
    /// 병동 번호
    let ward: Int
    /// 병상 번호
    let bed: Int
}
