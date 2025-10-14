//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 환자 생성 요청 DTO
/// - 목적: 새 환자를 생성할 때 클라이언트가 서버로 전송하는 데이터 모델
/// - Content: Vapor의 Content를 채택하여 JSON 인코딩/디코딩을 지원
struct PatientCreateRequest: Content {
    let name: String          // 환자 이름
    let ward: Int            // 병동 번호
    let bed: Int             // 병상(침대) 번호
    let departmentId: String // 진료과(부서) 식별자
    let deviceSerial: String // 환자 장치(웨어러블/모니터) 시리얼 번호
    let memo: String          // 비고/메모
}

/// 환자 생성 응답 DTO
/// - 목적: 환자 생성 성공 후 서버가 클라이언트로 반환하는 데이터 모델
/// - 주의: `currentLocation`은 서버가 계산/결정한 현재 위치 정보
struct PatientCreateResponseDTO: Content {
    let patientId: Int       // 생성된 환자의 고유 ID
    let name: String          // 환자 이름(확인용)
    let currentLocation: Location // 환자의 현재 위치 정보(병동/병상 등)
}
