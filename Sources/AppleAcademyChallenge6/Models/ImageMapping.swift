//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class ImageMapping: Model, Content, @unchecked Sendable {
    static let schema: String = SchemaValue.imageMapping
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: CommonIdField.photoId)
    var image: Image
    
    @Parent(key: CommonIdField.hospitalId)
    var hospital: HospitalAccount
    
    @OptionalParent(key: CommonIdField.contactId)
    var contact: Contact?
    
    @OptionalParent(key: CommonIdField.reportId)
    var report: Report?
    
    @Field(key: ImageMappingField.targetType)
    var targetType: TargetType
    
    @Field(key: CommonIdField.targetId)
    var targetId: UUID
    
    init() {}
    
    init(
        id: UUID? = nil,
        imageID: UUID,
        hospitalID: UUID,
        targetType: TargetType,
        targetId: UUID
    ) {
        self.id = id
        self.$image.id = imageID
        self.$hospital.id = hospitalID
        self.targetType = targetType
        self.targetId = targetId
    }
}
