//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/29/25.
//

import Vapor

enum ReportType: String, Codable, Content {
    case inquiry = "inquiry"
    case bug = "bug"
}
