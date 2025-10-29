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
struct DepartmentSummaryDTO: Content {
    let id: UUID
    let name: String
    let code: String
    let description: String
    let patientCount: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
        case description
        case patientCount = "pateint_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}

struct DepartmentAllResponse: Content {
    let totalCount: Int
    let departments: [DepartmentSummaryDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case departments
    }
}
