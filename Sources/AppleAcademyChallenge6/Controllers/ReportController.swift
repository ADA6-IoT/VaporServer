//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor

struct ReportController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let reports = routes.grouped("api", "reports")
        let protected = reports.grouped(JWTMiddleware())
    }
    
    func submitInquiry(_ req: Request) async throws -> CommonResponseDTO<ReportDTO> {
        let sessionToken = try req.requireAuth()
        let content = try req.content.decode(InquiryRequest.self)
        
        let s3Service = req.di.makeS3Service(request: req)
        var imageUrls: [String] = []
        
        if let images = content.images {
            for image in images {
                let imageUrl = try await s3Service.uploadImage(
                    data: image.data,
                    filename: image.filename,
                    folder: "Inquiries"
                )
                imageUrls.append(imageUrl)
            }
        }
        
        let reportService = req.di.makeReportService(request: req)
        let report = try await reportService.submitInquiry(
            hospitalId: sessionToken.hospitalId,
            content: content.content,
            email: content.email,
            images: imageUrls
        )
        try await report.$images.load(on: req.db)
        
        let result = ReportDTO(from: report)
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "문의가 성공적으로 접수되었습니다.", result: result)
    }
}
