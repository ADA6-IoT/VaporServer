//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

struct PatientRevisionPath: Content {
    let id: UUID
}

struct PatientRevisionRequest: Content {
    /// 환자 이름 (선택)
    let name: String?
    /// 병동 번호 (선택)
    let ward: Int?
    /// 병상 번호 (선택)
    let bed: Int?
    /// 소속 진료과 ID (선택)
    let departmentId: String?
    /// 연결된 디바이스 일련번호 (선택)
    let deviceSerial: String?
    /// 비고/메모 (선택)
    let memo: String?
}
