//
//  DriverAPI.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


// Driver management related API requests

import Foundation

// MARK: - Driver Registration
struct DriverRegisterRequest: APIRequest {
    typealias Response = APIResponse<DriverInfo>
    var path: String { "api/driverRegisterAndroid" }
    var method: HTTPMethod { .post }
    
    let token: String
    let carPlate: String
    let identity: String
    let brand: String
    let model: String
    let year: String
    let status: String
    let account: String
    let referredBy: String?
    let linkType: String
    let image: String
    let image2: String
    let document: String
    let documentName: String
    let documentId: String
    let documentIdName: String
    
    var body: Data? {
        var dict: [String: String] = [
            "token": token,
            "carPlate": carPlate,
            "identity": identity,
            "brand": brand,
            "model": model,
            "year": year,
            "status": status,
            "account": account,
            "link_type": linkType,
            "image": image,
            "image2": image2,
            "document": document,
            "document_name": documentName,
            "document_id": documentId,
            "document_id_name": documentIdName
        ]
        if let referredBy = referredBy { dict["referred_by"] = referredBy }
        return try? JSONSerialization.data(withJSONObject: dict)
    }
}

// MARK: - Update Driver Profile
struct UpdateDriverProfileRequest: APIRequest {
    typealias Response = APIResponse<DriverInfo>
    var path: String { "api/updateDriverDataAndroid" }
    var method: HTTPMethod { .post }
    
    let params: [String: String]
    
    var body: Data? {
        try? JSONSerialization.data(withJSONObject: params)
    }
}

// MARK: - Driver Online/Offline Status
struct DriverOnlineStatusRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/online" }
    var method: HTTPMethod { .post }
    
    let token: String
    let status: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "status": status
        ])
    }
}

// MARK: - Update Driver Coordinate
struct UpdateDriverCoordinateRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/updateCoordinate" }
    var method: HTTPMethod { .post }
    
    let token: String
    let lat: String
    let long: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "lat": lat,
            "long": long
        ])
    }
}

// MARK: - Get Driver Location
struct GetDriverLocationRequest: APIRequest {
    typealias Response = APIResponse<DriverInfo>
    var path: String { "api/getDriverLocation" }
    var method: HTTPMethod { .get }
    
    let driverId: String
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "driverId", value: driverId)]
    }
}

// MARK: - Search Drivers
struct SearchDriverRequest: APIRequest {
    typealias Response = APIResponse<[DriverInfo]>
    var path: String { "api/searchDriver" }
    var method: HTTPMethod { .get }
    
    let startLat: String
    let startLong: String
    let carType: String
    let distance: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "startLat", value: startLat),
            URLQueryItem(name: "startLong", value: startLong),
            URLQueryItem(name: "carType", value: carType),
            URLQueryItem(name: "distance", value: distance)
        ]
    }
}
