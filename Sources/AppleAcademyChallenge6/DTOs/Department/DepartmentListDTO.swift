//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/**
/// 부서(소속) 정보를 내려주는 응답 DTO
///
/// - Note: Vapor의 `Content`를 채택하여 JSON 인코딩/디코딩에 사용됩니다.
/// - Usage: 부서 목록 조회 API의 응답 바디로 전달됩니다.
*/
struct DepartmentResponseDTO: Content {
    /// 부서 고유 식별자 (예: UUID 문자열)
    let departmentId: String
    /// 부서명 (사내 표시 이름)
    let departmentName: String
}

