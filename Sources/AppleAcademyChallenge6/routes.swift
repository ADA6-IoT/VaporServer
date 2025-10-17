//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor

func routes(_ app: Application) throws {1
    app.get("ping") { req async in
        return "pong"
    }
}
