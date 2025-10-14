//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// DTO(Data Transfer Object) 정의 파일
/// Vapor의 `Content`를 채택하여 JSON 인코딩/디코딩에 사용됩니다.

/// 기기 검색 요청 DTO
/// - Note: 검색 키워드를 서버로 전달합니다.
struct DeviceSearchQueryDTO: Content {
    /// 검색 키워드 (시리얼/디바이스 번호/환자명 등 부분 일치 검색에 사용)
    let keyword: String
}

/// 기기 검색 응답 DTO
/// 서버가 반환하는 단일 기기 정보입니다.
/// - serialNumber: 기기 시리얼 번호
/// - deviceNumber: 내부 디바이스 관리 번호
/// - isAssigned: 환자에게 현재 할당되어 있는지 여부
/// - isMalfunction: 고장/이상 상태 여부
/// - assignedPatientName: 할당된 환자 이름 (미할당 시 빈 문자열일 수 있음)
/// - batteryLevel: 배터리 잔량(%)
/// - wifiSignalStrength: Wi‑Fi 신호 세기(dBm 또는 정규화 값)
struct DeviceSearchResponseDTO: Content {
    let deviceInfo: [DeviceDTO]
}
