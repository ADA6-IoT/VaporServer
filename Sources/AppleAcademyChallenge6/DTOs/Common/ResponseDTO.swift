//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

struct ResponseDTO<T: Content>: Content {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T?
    
    init(isSuccess: Bool = true, code: String = "COMMON201", message: String, result: T? = nil) {
        self.isSuccess = isSuccess
        self.code = code
        self.message = message
        self.result = result
    }
}

extension ResponseDTO where T == EmptyResponse {
    static func error(_ message: String) -> ResponseDTO {
        return ResponseDTO(isSuccess: false, code: "COMMON401", message: message, result: nil)
    }
}


struct EmptyResponse: Content {}
