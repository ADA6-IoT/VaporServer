//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/16/25.
//

import Vapor

import Vapor

enum PatientMigrations {
    static func register(on app: Application) {
        // 1. 먼저 참조될 기본 테이블들 생성
        app.migrations.add(CreateDepartment())
        app.migrations.add(CreateWard())
        app.migrations.add(CreateBed())
        
        // 2. 외래키로 위 테이블들을 참조하는 테이블 생성
        app.migrations.add(CreatePatient())
        
        // 3. patients를 참조하는 테이블은 마지막에
        app.migrations.add(CreateLocation())
    }
}
