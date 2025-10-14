//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 병원 문의 요청 페이로드 모델
///
/// 클라이언트가 서버로 전송하는 병원 문의 데이터를 표현합니다.
/// Vapor의 `Content`를 채택하여 JSON 인코딩/디코딩과 멀티파트 업로드를 지원합니다.
struct AppInquiryRequest: Content {
    /// 문의 내용 작성
    let inquiryContent: String
    /// 첨부 이미지 파일 배열
    /// - Note: 멀티파트(form-data) 업로드 시 사용됩니다.
    let image: [File]?
}

/// 앱 문의 등록 응답 페이로드 모델
///
/// 서버가 클라이언트로 반환하는 표준 응답 형식입니다.
struct AppInquiryResponse: Content {
    /// 문의 식별자 (예: "APP-INQ-20251005-0001")
    let inquiryId: String
    /// 문의 내용
    let inquiryContent: String
    /// 업로드된 이미지 접근 URL 목록
    let imageUrls: [String]
    /// 생성 시각 (ISO8601 문자열, 예: "2025-10-05T12:40:22Z")
    let createdAt: String
}
