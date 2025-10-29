//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 환자 이름으로 기기 검색 요청 DTO
struct DeviceSearchQuery: Content {
    /// 검색 키워드 (시리얼/디바이스 번호/환자명 등 부분 일치 검색에 사용)
    let keyword: String
}

/// 기기 검색 응답 DTO
struct DeviceSearchResponse: Content {
    let keyword: String
    let totalCount: Int
    let devices: [DeviceDTO]
    
    enum CodingKeys: String, CodingKey {
        case keyword
        case totalCount = "total_count"
        case devices
    }
}
