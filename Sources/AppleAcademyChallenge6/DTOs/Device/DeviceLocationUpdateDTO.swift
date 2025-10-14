//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

// 장치 위치 업데이트 요청에 사용되는 페이로드 모델
// 클라이언트가 서버로 장치의 현재 상태와 위치 정보를 전송할 때 사용합니다.
struct DeviceLocationUpdateRequestDTO: Content {
    // Wi‑Fi 관련 정보 (SSID/BSSID)
    let wifiInfo: DeviceLocationWifiInfo
    // 신호 세기, 배터리 등 장치 상태 값
    let valueInfo: DeviceLocationValueInfo
    // 장치의 원시 위치 좌표(예: 위도/경도 또는 내부 좌표)
    let location: Location
}

// Wi‑Fi 정보 모델
struct DeviceLocationWifiInfo: Content {
    // 연결된 AP의 네트워크 이름
    let ssid: String
    // AP의 BSSID(맥 주소)
    let bssid: String
}

// 장치 상태 값 모델
struct DeviceLocationValueInfo: Content {
    // Wi‑Fi 신호 세기 (예: dBm 또는 상대 지표)
    let signalStrength: Int
    // 배터리 잔량(%)
    let batteryInfo: Int
}

// 장치 위치 업데이트 응답 모델
// 서버가 저장/매핑 결과와 함께 반환하는 정보입니다.
struct DeviceLocationUpdateResponseDTO: Content {
    // 장치 일련번호
    let serialNumber: String
    // 요청 시 전달된 Wi‑Fi 정보(또는 정규화된 값)
    let wifiInfo: DeviceLocationWifiInfo
    // 요청 시 전달된 장치 상태 값(또는 정규화된 값)
    let valueInfo: DeviceLocationValueInfo
    // 원시 위치 정보
    let location: Location
    // 서버에서 내부 맵/층 정보로 매핑한 결과
    let mappedLocation: MappedLocation
    // 데이터가 갱신된 시각(서버 기준)
    let updatedAt: Date
}

// 맵 상의 위치(층/병동 등)로 변환된 결과 모델
struct MappedLocation: Content {
    // 층 정보 (예: 1층, 2층)
    let floor: Int
    // 병동/구역 이름
    let ward: Int
}
