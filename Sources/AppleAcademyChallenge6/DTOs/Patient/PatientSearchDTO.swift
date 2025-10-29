//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 환자 검색 요청에 사용되는 DTO
struct PatientSearchPath: Content {
    /// 검색 키워드 (예: 환자 이름, 기기 시리얼, 병동/병상 등)
    let keyword: String
}

/// 환자 검색 결과 응답에 사용되는 DTO
/// - Note: 서버가 검색된 환자 정보를 요약 형태로 반환합니다.
struct PatientSearchResponse: Content {
    let keyword: String
    let totalCount: Int
    let patients: [PatientDTO]
    
    enum CodingKeys: String, CodingKey {
        case keyword
        case totalCount = "total_count"
        case patients
    }
}
