//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

enum PatientMigrations {
    static func register(on app: Application) {
        app.migrations.add(CreatePatient())
        app.migrations.add(CreateBed())
        app.migrations.add(CreateDepartment())
        app.migrations.add(CreateLocation())
        app.migrations.add(CreateWard())
    }
}
