//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/30/25.
//

import Vapor

struct BugReportRequest: Content {
    let type: ReportType
    let content: String
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case content, images, type
    }
}
