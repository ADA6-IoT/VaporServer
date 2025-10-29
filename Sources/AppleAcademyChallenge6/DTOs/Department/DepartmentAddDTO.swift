//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 병원 소속(진료과 등) 생성 요청 DTO
/// - note: 여러 부서를 한 번에 생성할 수 있도록 부서명을 배열로 받습니다.
struct DepartmentAddRequest: Content {
    let name: String
    let code: String
    let decription: String?
}

