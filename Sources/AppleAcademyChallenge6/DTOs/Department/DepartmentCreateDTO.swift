//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 병원 소속(진료과 등) 생성 요청 DTO
/// - note: 여러 부서를 한 번에 생성할 수 있도록 부서명을 배열로 받습니다.
struct DepartmentCreateRequest: Content {
    /// 생성할 부서명 목록 (예: ["내과", "외과"]) 
    let departmentName: [String]
}

/// 병원 소속(진료과 등) 생성 응답 DTO
/// - note: 생성이 완료된 단일 부서명을 반환합니다.
struct DepartmentCreateResponse: Content {
    /// 생성 완료된 부서명 (예: "내과")
    let departmentName: [String]
}

