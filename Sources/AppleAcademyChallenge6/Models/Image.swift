//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class Image: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.image
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: ImageField.imageUrl)
    var imageUrl: String
    
    @Field(key: ImageField.image_type)
    var imageType: TargetType
    
    @Children(for: \.$image)
    var imageMappings: [ImageMapping]
}

enum TargetType: String, Codable {
    case contact = "contact"
    case report = "report"
}
