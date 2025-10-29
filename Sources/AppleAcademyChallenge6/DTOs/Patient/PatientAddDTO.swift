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
struct PatientAddRequest: Content {
    let name: String          // 환자 이름
    let ward: Int            // 병동 번호
    let bed: Int             // 병상(침대) 번호
    let departmentId: String // 진료과(부서) 식별자
    let deviceSerial: String // 환자 장치(웨어러블/모니터) 시리얼 번호
    let memo: String?         // 비고/메모
}
