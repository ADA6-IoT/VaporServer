//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

enum AuthMigrations {
    static func register(on app: Application) {
        app.migrations.add(CreateHospitalAccount())
        app.migrations.add(CreateHospitalAccountToken())
    }
}
