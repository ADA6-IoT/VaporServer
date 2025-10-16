//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

enum ImageMigrations {
    static func register(on app: Application) {
        app.migrations.add(CreateImage())
        app.migrations.add(CreateImageMapping())
    }
}
