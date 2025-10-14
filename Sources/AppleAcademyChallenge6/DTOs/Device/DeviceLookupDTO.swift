//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 서버에 등록된 기기 정보를 나타내는 Response DTO
/// - Note: 서버에서 반환하는 JSON을 디코딩하기 위한 모델입니다.
struct DeviceLookupResponseDTO: Content {
    /// 기기의 고유 일련번호 (Serial Number)
    let serialNumber: String
    /// 기기 표시 이름 (관리자가 지정한 별칭 또는 시스템 이름)
    let deviceName: String
    /// 기기가 현재 사용자/업무에 할당되었는지 여부
    let isAssigned: Bool
    /// 기기 고장 여부
    let isMalfunction: Bool
    /// 배터리 잔량 퍼센트 (0~100)
    let batteryLevel: Int
    /// Wi‑Fi 신호 세기 (dBm 또는 내부 스케일)
    /// - Important: 값의 범위/스케일은 서버 정의에 따릅니다.
    let wifiSignalStrength: Int
}
