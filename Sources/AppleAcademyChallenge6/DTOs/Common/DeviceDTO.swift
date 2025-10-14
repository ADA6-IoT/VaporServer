//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

struct DeviceDTO: Content {
    /// 기기 시리얼 번호 (제조사 고유 식별자)
    let serialNumber: String
    /// 내부 디바이스 관리 번호 (자체 자산 관리용)
    let deviceNumber: String
    /// 환자에게 현재 할당되어 있는지 여부
    let isAssigned: Bool
    /// 고장 또는 이상 상태 여부
    let isMalfunction: Bool
    /// 할당된 환자 이름 (미할당 시 빈 문자열)
    let assignedPatientName: String?
    /// 배터리 잔량(%) (0~100)
    let batteryLevel: Int
    /// Wi‑Fi 신호 세기 (플랫폼 정의 값)
    let wifiSignalStrength: Int
}
