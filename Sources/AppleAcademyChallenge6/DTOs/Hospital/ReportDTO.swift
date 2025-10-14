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
struct ReportRequestDTO: Content {
    /// 문의/설명 본문 텍스트
    /// - Example: "기기 연결이 자주 끊어집니다. 로그 첨부합니다."
    let reportContent: String
    /// 첨부 이미지 파일 목록 (선택)
    /// Vapor의 `File` 타입을 사용하며, multipart 업로드에서 매핑됩니다.
    /// - Note: 비어 있을 수 있습니다.
    let image: [File]?
}

/// 앱 문의 등록 응답 페이로드 모델
/// 서버가 클라이언트로 반환하는 표준 응답 형식입니다.
struct ReportResponseDTO: Content {
    /// 문의 식별자 (예: "APP-INQ-20251005-0001")
    let reportId: String
    /// 문의 유형 (예: "IoT")
    let reportContent: String
    /// 업로드된 이미지 접근 URL 목록
    let imageUrls: [String]
    /// 생성 시각 (ISO8601 문자열, 예: "2025-10-05T12:40:22Z")
    let createdAt: String
}
