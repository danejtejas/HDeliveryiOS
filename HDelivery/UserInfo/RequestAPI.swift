//
//  RequestAPI.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// RequestAPI.swift
// Driver request management related API requests

import Foundation

// MARK: - Delete Driver Request
struct DeleteDriverRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/taskerDeleteRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var body: Data? {
        try? JSONEncoder().encode(["token": token])
    }
}

// MARK: - Dismiss Specific Request
struct DismissDriverRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/dismissRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    let requestId: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "requestId": requestId
        ])
    }
}
