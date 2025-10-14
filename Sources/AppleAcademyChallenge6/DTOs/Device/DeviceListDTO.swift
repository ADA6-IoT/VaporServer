//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

// Vapor 프레임워크를 사용하기 위해 임포트합니다.
// Vapor의 Content 프로토콜을 채택하면 자동으로 JSON 인코딩/디코딩이 가능합니다.
import Vapor

/// 디바이스 목록 API의 응답을 표현하는 DTO(Data Transfer Object)입니다.
/// - Note: `Content`를 채택하여 Vapor가 JSON으로 자동 직렬화/역직렬화를 수행합니다.
struct DeviceListResponseDTO: Content {
    /// 응답 본문에 포함될 디바이스 정보 배열입니다.
    /// 각 요소는 단일 디바이스를 나타내는 `DeviceDTO` 입니다.
    let deviceInfo: [DeviceDTO]
}
