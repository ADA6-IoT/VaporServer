//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

/// 병원 계정 회원 가입 요청 DTO
/// - 목적: 클라이언트가 병원 계정을 신규 생성할 때 서버로 전달하는 요청 페이로드.
/// - 인코딩: Vapor `Content`를 채택하여 JSON 인코딩/디코딩을 지원합니다.
/// - 사용 맥락: 회원가입 API(예: POST /hospitals/signup)에 바디로 전달됩니다.
struct HospitalAccountRequestDTO: Content {
    /// 병원 로그인에 사용할 고유 식별자 (예: 이메일 또는 사번 형식)
    let hospitalId: String
    /// 계정 비밀번호(전송 시 HTTPS 사용, 서버에서 해시/솔트 처리 권장)
    let hospitalPwd: String
    /// 병원(기관) 표시 이름. 사용자에게 노출될 수 있습니다.
    let hospitalName: String
}

/// 병원 계정 생성 성공 시 응답 DTO
/// - 목적: 회원가입 처리 완료 후 클라이언트에 반환되는 결과 데이터.
/// - 보안 참고: 실제 서비스에서는 비밀번호 원문을 응답에 포함하지 않는 것이 일반적입니다.
///   필요 시 마스킹 또는 제외하도록 API 스펙을 조정하세요.
struct HospitalAccountResponseDTO: Content {
    /// 생성된 계정의 고유 식별자
    let hospitalId: String
    /// 등록된 병원(기관) 이름
    let hospitalName: String
    /// 생성 날짜 입력
    let createdAt: String
}
