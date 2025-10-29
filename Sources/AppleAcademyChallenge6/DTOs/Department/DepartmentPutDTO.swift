//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DepartmentPutPath: Content {
    let id: UUID
}

struct DepartmentPutRequest: Content {
    let name: String?
    let code: String?
    let description: String?
}
