//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

enum ReportMigrations {
    static func register(on app: Application) {
        app.migrations.add(CreateContact())
        app.migrations.add(CreateReport())
    }
}
