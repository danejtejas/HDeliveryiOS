//
//  UtilityAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// UtilityAPI.swift
// Utility related API requests

import Foundation

// MARK: - Show Car Types
struct ShowCarTypesRequest: APIRequest {
    typealias Response = APIResponse<[String]> // Adjust to actual car type model if needed
    var path: String { "api/showCarType" }
    var method: HTTPMethod { .post }
    
    // No parameters required
}

// MARK: - Show State & City
struct ShowStateCityRequest: APIRequest {
    typealias Response = APIResponse<[String]> // Replace with proper state/city model if defined
    var path: String { "api/showStateCity" }
    var method: HTTPMethod { .get }
    
    // No parameters required
}

// MARK: - Get Items
struct GetItemsRequest: APIRequest {
    typealias Response = APIResponse<[String]> // Replace with proper Item model if needed
    var path: String { "api/items" }
    var method: HTTPMethod { .get }
    
    let jobType: String
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "job_type", value: jobType)]
    }
}

// MARK: - General Settings
struct GeneralSettingsRequest: APIRequest {
    typealias Response = APIResponse<[String: String]> // Replace with actual settings model
    var path: String { "api/generalSettings" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var body: Data? {
        try? JSONEncoder().encode(["token": token])
    }
}

// MARK: - Share App
struct ShareAppRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/shareApp" }
    var method: HTTPMethod { .post }
    
    let token: String
    let type: String
    let social: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "type": type,
            "social": social
        ])
    }
}

// MARK: - Need Help Trip
struct NeedHelpTripRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/needHelpTrip" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "tripId": tripId
        ])
    }
}
