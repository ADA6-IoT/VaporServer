//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/17/25.
//

// Sources/App/DI/DIContainer.swift

import Vapor
import Fluent

final class DIContainer: Sendable {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Services
    
    func makeAuthService(app: Application) -> AuthService {
        AuthService(database: app.db, app: app)
    }
    
    func makeDepartmentService(app: Application) -> DepartmentService {
        DepartmentService(database: app.db)
    }
    
    func makePatientService(app: Application) -> PatientService {
        PatientService(
            database: app.db,
            deviceService: makeDeviceService(app: app)
        )
    }
    
    func makeDeviceService(app: Application) -> DeviceService {
        DeviceService(database: app.db)
    }
    
    func makeAnchorService(app: Application) -> AnchorService {
        AnchorService(database: app.db)
    }
    
    func makeLocationService(app: Application) -> LocationService {
        LocationService(
            database: app.db,
            deviceService: makeDeviceService(app: app),
            anchorService: makeAnchorService(app: app)
        )
    }
    
    func makeReportService(app: Application) -> ReportService {
        ReportService(database: app.db)
    }
}
