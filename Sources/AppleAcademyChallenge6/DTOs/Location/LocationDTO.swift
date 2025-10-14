//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
/// 위도, 경도 값
struct Location: Content {
    let latitude: Double
    let longitude: Double
}
