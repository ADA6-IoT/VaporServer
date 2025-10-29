//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 전체 환자 조회 시 사용하는 응답 DTO
struct PatientAllQuery: Content {
    let floor: Int?
    let ward: Int?
}

struct PatientAllResponse: Content {
    let totalCount: Int
    let patients: [PatientDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case patients
    }
}
