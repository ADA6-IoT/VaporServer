//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 병원 로그인 Request
/// - 설명: 병원(관리자) 계정으로 인증을 시도할 때 서버로 전송하는 요청 바디입니다.
/// - 사용처: 로그인 API의 HTTP Body(JSON)로 인코딩되어 전송됩니다. `Content` 채택으로 Vapor의 자동 인코딩/디코딩을 지원합니다.
/// - 참고: 네트워크 구간은 TLS(HTTPS)로 보호되어야 하며, 비밀번호는 절대로 로깅하거나 평문으로 저장하지 마세요.
struct HospitalLoginRequest: Content {
    /// 로그인에 사용하는 계정 ID(예: 이메일, 사번, 사용자명 등 서버 정의 규칙을 따름)
    let loginID: String
    /// 계정 비밀번호(평문 보관 금지, 키체인 저장 시에도 주의)
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case loginID = "login_id"
        case password
    }
}

/// 병원 로그인 Response
/// - 설명: 인증 성공 시 서버가 반환하는 토큰 및 부가 정보입니다.
/// - 토큰: `accessToken`은 짧은 수명의 액세스 토큰, `refreshToken`은 재발급용 장기 토큰입니다.
/// - 만료: `expiresAt`은 액세스 토큰의 만료 시각입니다. 만료 전 토큰 갱신 로직을 구현하세요.
/// - 직렬화: Vapor `Content`를 통해 JSON <-> 모델 변환이 자동 처리됩니다. 서버/클라이언트 간 날짜 포맷(ISO8601 등) 합의가 필요합니다.
struct HospitalLoginResponse: Content {
    let id: UUID
    /// 로그인된 병원의 표시 이름(대시보드/상단 바 등 UI 표시에 사용)
    let hospitalName: String
    /// 인증된 요청에 포함할 액세스 토큰(짧은 수명, Authorization 헤더에 Bearer로 첨부)
    let accessToken: String
    /// 액세스 토큰이 만료되었을 때 재발급을 위한 리프레시 토큰(보다 긴 수명, 안전한 저장 필요)
    let refreshToken: String
    /// 액세스 토큰 만료 시각(클라이언트 로컬 시계와의 오차를 고려해 여유를 두고 갱신 권장)
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hospitalName = "hospital_name"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
}

