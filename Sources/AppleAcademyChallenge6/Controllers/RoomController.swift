//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 11/13/25.
//

import Vapor
import Fluent

struct RoomController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let rooms = routes.grouped("api", "rooms")
        
        let protected = rooms.grouped(JWTMiddleware())
    }
    
    // MARK: - List
       
       /// 병실 목록 조회
       ///
       /// **엔드포인트:** `GET /api/rooms`
       ///
       /// **요청 헤더:**
       /// ```
       /// Authorization: Bearer {access_token}
       /// ```
       ///
       /// **응답:**
       /// ```json
       /// {
       ///   "is_success": true,
       ///   "code": "COMMON200",
       ///   "message": "병실 목록 조회 성공",
       ///   "result": {
       ///     "floors": [
       ///       {
       ///         "floor": 3,
       ///         "rooms": [
       ///           {
       ///             "id": "...",
       ///             "floor": 3,
       ///             "room_number": "301",
       ///             "bed_count": 4,
       ///             "room_type": "일반실"
       ///           }
       ///         ]
       ///       }
       ///     ]
       ///   }
       /// }
       /// ```
    func list(_ req: Request) async throws -> CommonResponseDTO<RoomsGroupedByFloorDTO> {
        let sessionToken = try req.requireAuth()
        let service = req.di.makeRoomService(request: req)
        let rooms = try await service.list(hospitalId: sessionToken.hospitalId)
        let result = RoomsGroupedByFloorDTO(rooms: rooms)
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "병실 목록 조회 성공", result: result)
    }
    
    // MARK: - Get
       
       /// 병실 단건 조회
       ///
       /// **엔드포인트:** `GET /api/rooms/:id`
       ///
       /// **요청 헤더:**
       /// ```
       /// Authorization: Bearer {access_token}
       /// ```
       ///
       /// **응답:**
       /// ```json
       /// {
       ///   "is_success": true,
       ///   "code": "COMMON200",
       ///   "message": "병실 조회 성공",
       ///   "result": {
       ///     "id": "...",
       ///     "floor": 3,
       ///     "room_number": "301",
       ///     "bed_count": 4,
       ///     "room_type": "일반실",
       ///     "created_at": "2025-11-03T10:00:00Z"
       ///   }
       /// }
       /// ```
    func get(_ req: Request) async throws -> CommonResponseDTO<RoomDTO> {
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makeRoomService(request: req)
        let room = try await service.get(id: id, hospitalId: sessionToken.hospitalId)
        let result = RoomDTO(from: room)
        
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "병실 조회 성공", result: result)
    }
    
    // MARK: - Create
       
       /// 병실 생성
       ///
       /// **엔드포인트:** `POST /api/rooms`
       ///
       /// **요청 헤더:**
       /// ```
       /// Authorization: Bearer {access_token}
       /// ```
       ///
       /// **요청 바디:**
       /// ```json
       /// {
       ///   "floor": 3,
       ///   "room_number": "301",
       ///   "bed_count": 4,
       ///   "room_type": "일반실"
       /// }
       /// ```
       ///
       /// **응답:**
       /// ```json
       /// {
       ///   "is_success": true,
       ///   "code": "CREATED201",
       ///   "message": "병실 생성 성공",
       ///   "result": {
       ///     "id": "...",
       ///     "floor": 3,
       ///     "room_number": "301",
       ///     "bed_count": 4,
       ///     "room_type": "일반실"
       ///   }
       /// }
       /// ```
    func create(_ req: Request) async throws -> CommonResponseDTO<RoomDTO> {
        try CreateRoomRequestDTO.validate(content: req)
        let dto = try req.content.decode(CreateRoomRequestDTO.self)
        
        let sessionToken = try req.requireAuth()
        let service = req.di.makeRoomService(request: req)
        let room = try await service.create(
            hospitalId: sessionToken.hospitalId,
            floor: dto.floor,
            roomNumber: dto.roomNumber,
            bedCount: dto.bedCount
        )
        
        let result = RoomDTO(from: room)
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "병실 생성 성공", result: result)
    }
    // MARK: - Bulk Create
        
        /// 병실 일괄 생성
        ///
        /// **엔드포인트:** `POST /api/rooms/bulk`
        ///
        /// **요청 헤더:**
        /// ```
        /// Authorization: Bearer {access_token}
        /// ```
        ///
        /// **요청 바디:**
        /// ```json
        /// {
        ///   "floor": 3,
        ///   "start_room_number": 301,
        ///   "end_room_number": 310,
        ///   "bed_count": 4,
        ///   "room_type": "일반실"
        /// }
        /// ```
        ///
        /// **응답:**
        /// ```json
        /// {
        ///   "is_success": true,
        ///   "code": "CREATED201",
        ///   "message": "병실 일괄 생성 완료",
        ///   "result": {
        ///     "total_count": 10,
        ///     "success_count": 10,
        ///     "failed_count": 0,
        ///     "failed_rooms": []
        ///   }
        /// }
        /// ```
    func bulkCreate(_ req: Request) async throws -> CommonResponseDTO<BulkCreateResult> {
        let dto = try req.content.decode(BulkCreateRoomsRequestDTO.self)
        try dto.validate()
        
        let sessionToken = try req.requireAuth()
        let service = req.di.makeRoomService(request: req)
        let result = try await service.bulkCreate(
            hospitalId: sessionToken.hospitalId,
            floor: dto.floor,
            startRoomNumber: dto.startRoomNumber,
            endRoomNumber: dto.endRoomNumber,
            bedCount: dto.bedCount
        )
        
        return CommonResponseDTO.success(code: ResponseCode.CREATED201, message: "병실 일괄 생성 완료", result: result)
    }
    
    // MARK: - Update
        
        /// 병실 수정
        ///
        /// **엔드포인트:** `PATCH /api/rooms/:id`
        ///
        /// **요청 헤더:**
        /// ```
        /// Authorization: Bearer {access_token}
        /// ```
        ///
        /// **요청 바디:**
        /// ```json
        /// {
        ///   "floor": 4,
        ///   "room_number": "401",
        ///   "bed_count": 6,
        ///   "room_type": "특실"
        /// }
        /// ```
        ///
        /// **응답:**
        /// ```json
        /// {
        ///   "is_success": true,
        ///   "code": "COMMON200",
        ///   "message": "병실 수정 성공",
        ///   "result": {
        ///     "id": "...",
        ///     "floor": 4,
        ///     "room_number": "401",
        ///     "bed_count": 6,
        ///     "room_type": "특실"
        ///   }
        /// }
        /// ```
    func update(_ req: Request) async throws -> CommonResponseDTO<RoomDTO> {
        let dto = try req.content.decode(UpdateRoomRequestDTO.self)
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makeRoomService(request: req)
        let room = try await service.update(
            id: id,
            hospitalId: sessionToken.hospitalId,
            floor: dto.floor,
            roomNumber: dto.roomNumber,
            bedCount: dto.bedCount
        )
        
        let result = RoomDTO(from: room)
        return CommonResponseDTO.success(code: ResponseCode.COMMON200, message: "병실 수정 성공", result: result)
    }
    
    // MARK: - Delete
        
        /// 병실 삭제
        ///
        /// **엔드포인트:** `DELETE /api/rooms/:id`
        ///
        /// **요청 헤더:**
        /// ```
        /// Authorization: Bearer {access_token}
        /// ```
        ///
        /// **응답:**
        /// ```json
        /// {
        ///   "is_success": true,
        ///   "code": "COMMON200",
        ///   "message": "병실 삭제 성공"
        /// }
        /// ```
    func delete(_ req: Request) async throws -> CommonResponseDTO<EmptyResponse> {
        let sessionToken = try req.requireAuth()
        let id = try req.parameters.require("id", as: UUID.self)
        let service = req.di.makeRoomService(request: req)
        try await service.delete(id: id, hospitalId: sessionToken.hospitalId)
        
        return CommonResponseDTO.successNoData(code: ResponseCode.COMMON200, message: "병실 삭제 성공")
    }
    
    func deleteAll(_ req: Request) async throws -> CommonResponseDTO<EmptyResponse> {
        let sessionToken = try req.requireAuth()
        let service = req.di.makeRoomService(request: req)
        try await service.deleteAll(hospitalId: sessionToken.hospitalId)
        return CommonResponseDTO.successNoData(code: ResponseCode.COMMON200, message: "병실 전체 삭제 성공")
    }
}
