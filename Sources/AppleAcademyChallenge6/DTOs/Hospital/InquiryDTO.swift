//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

struct InquiryRequest: Content {
    let contents: String
    let email: String
    let images: [Data]?
}

struct InquiryResponse: Content {
    let id: UUID
    let type: String
    let content: String
    let email: String?
    let status: String
    let images: [String]
    let hospital: HospitalDTO
    let createdAt: Date
    let updatedAt: Date
    let adminReply: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
        case email
        case status
        case images
        case hospital
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminReply = "admin_reply"
    }
}
