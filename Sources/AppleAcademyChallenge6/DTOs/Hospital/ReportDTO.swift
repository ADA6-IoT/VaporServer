//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/14/25.
//

import Vapor

/// 앱 문의(리포트) 생성 요청 페이로드
/// 클라이언트가 서버로 전송하는 본문 형식입니다.
/// - Note: Vapor `Content`를 채택하여 JSON 및 multipart/form-data 바인딩을 지원합니다.
struct ReportRequest: Content {
    let contents: String
    let images: [Data]?
}
