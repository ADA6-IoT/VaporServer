//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 환자 검색 요청에 사용되는 DTO
/// - Note: 클라이언트가 환자를 검색할 때 키워드(이름, 기기 시리얼, 병상 정보 등)를 전달합니다.
struct PatientSearchQueryDTO: Content {
    /// 검색 키워드 (예: 환자 이름, 기기 시리얼, 병동/병상 등)
    let keyword: String
}

/// 환자 검색 결과 응답에 사용되는 DTO
/// - Note: 서버가 검색된 환자 정보를 요약 형태로 반환합니다.
struct PatientSearchResponseDTO: Content {
    /// 환자 고유 식별자
    let patientId: Int
    /// 환자 이름(표시용)
    let name: String
    /// 환자가 속한 진료과/부서 이름
    let departmentName: String
    /// 환자에게 연결된 기기 시리얼 번호
    let deviceSerial: String
    /// 병동(ward) 번호
    let ward: Int
    /// 병상(bed) 번호
    let bed: Int
}
