//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/13/25.
//

import Vapor
import Fluent

final class ImageMapping: Model, Content, @unchecked Sendable {
    static let schema: String = "image_mapping"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "photo_id")
    var image: Image
    
    @Parent(key: "hospital_id")
    var hospital: HospitalAccount
    
    @OptionalParent(key: "contact_id")
    var contact: Contact?
    
    @OptionalParent(key: "report_id")
    var report: Report?
    
    @Field(key: "target_type")
    var targetType: TargetType
    
    @Field(key: "target_id")
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
