//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor
import VaporToOpenAPI

struct ReportController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let reports = routes.grouped("api", "reports")
        let protected = reports.grouped(JWTMiddleware())
        
        protected.on(.POST, "inquiry", body: .collect(maxSize: "10mb"), use: submitInquiry)
            .openAPI(
                tags: TagObject(name: TagObjectValue.report),
                summary: "문의/신고 접수",
                description: """
                 병원 시스템 관련 문의나 신고를 접수합니다.
                 
                 **Content-Type:** `multipart/form-data`
                 
                 **Form Fields:**
                 ```
                 content  : string   (required) - 문의 내용
                 email    : string   (required) - 이메일 주소
                 images   : file[]   (optional) - 이미지 파일들
                 ```
                 
                 **cURL 예시:**
                 ```bash
                 curl -X POST http://localhost:8080/api/reports/inquiry \\
                   -H "Authorization: Bearer YOUR_TOKEN" \\
                   -F "type=INQUIRY" \\
                   -F "content=문의 내용입니다" \\
                   -F "email=test@example.com" \\
                   -F "images=@image1.jpg" \\
                   -F "images=@image2.jpg"
                 ```
                 
                 **인증 필요:** Bearer Token
                 """,
                body: .type(of: InquiryRequest(
                      content: "문의 내용 예시",
                      email: "user@example.com",
                      images: nil
                  )),
                contentType: .multipart(.formData),
                response: .type(CommonResponseDTO<ReportDTO>.self)
            )
    }
    
    func submitInquiry(_ req: Request) async throws -> CommonResponseDTO<ReportDTO> {
        let sessionToken = try req.requireAuth()

        // Multipart form data를 직접 파싱
        let content = try req.content.get(String.self, at: "content")
        let email = try req.content.get(String.self, at: "email")
        let images = try? req.content.get([File].self, at: "images")

        let s3Service = req.di.makeS3Service(request: req)
        var imageUrls: [String] = []

        if let images = images {
            for image in images {
                let data = Data(buffer: image.data)
                let imageUrl = try await s3Service.uploadImage(
                    data: data,
                    filename: image.filename,
                    folder: "Inquiries"
                )
                imageUrls.append(imageUrl)
            }
        }

        let reportService = req.di.makeReportService(request: req)
        let report = try await reportService.submitInquiry(
            hospitalId: sessionToken.hospitalId,
            content: content,
            email: email,
            images: imageUrls
        )
        try await report.$images.load(on: req.db)

        let result = ReportDTO(from: report)
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "문의가 성공적으로 접수되었습니다.", result: result)
    }
}
