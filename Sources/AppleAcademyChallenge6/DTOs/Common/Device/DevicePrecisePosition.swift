//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/28/25.
//

import Vapor

struct DevicePrecisePosition: Content {
    let x: Double
    let y: Double
    let z: Double?
    
    enum CodingKeys: String, CodingKey {
        case x, y, z
    }
}
