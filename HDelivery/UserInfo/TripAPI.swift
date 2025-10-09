//
//  TripAPI.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


// TripAPI.swift
// Trip management related API requests

import Foundation

// MARK: - Create Trip Request
struct CreateTripRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/createRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    let link: String
    let startLat: String
    let startLong: String
    let startLocation: String
    let endLat: String
    let endLong: String
    let endLocation: String
    let estimateDistance: String
    let itemId: String // JSON string of items
    let receiver_phone : String
    
    
    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    var parameters: [String: String]? {
      return  [
            "token": token,
            "link": link,
            "startLat": startLat,
            "startLong": startLong,
            "startLocation": startLocation,
            "endLat": endLat,
            "endLong": endLong,
            "endLocation": endLocation,
            "estimateDistance": estimateDistance,
            "item_id": itemId,
            "receiver_phone" : receiver_phone
        ]
    }
    
    var body: Data? {
        
        
        var parts: [String] = []

        for key in parameters!.keys.sorted() {
            let value = parameters![key] ?? ""
            let stringValue = "\(value)"
            let encoded = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(key)=\(encoded)")
        }
        
        let formString = parts.joined(separator: "&")

        return formString.data(using: .utf8)
        
       }
    
    
}

// MARK: - Driver Confirm Trip
struct DriverConfirmRequest: APIRequest {
    typealias Response = APIResponse<TripData?>
    var path: String { "api/driverConfirm" }
    var method: HTTPMethod { .post }
    
    let token: String
    let requestId: String
    let startLat: String
    let startLong: String
    let startLocation: String
    
    var param : [String: Any] {
        [
            "token": token,
            "requestId": requestId,
            "startLat": startLat,
            "startLong": startLong,
            "startLocation": startLocation
        ]
    }
    
    
    var body: Data? {
       return param.toFormURLEncodedData()
    }
}

// MARK: - Start Trip
struct StartTripRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/startTrip" }
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

// MARK: - End Trip
struct EndTripRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/endTrip" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let distance: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "tripId": tripId,
            "distance": distance
        ])
    }
}

// MARK: - Cancel Trip
struct CancelTripRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/cancelTrip" }
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

// MARK: - Cancel Request
struct CancelRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/cancelRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    let driver: String // "0" for passenger
    
    var parameters: [String: String]? {
      return  [
            "token": token,
            "driver": driver
        ]
    }
    
    var body: Data? {
        var parts: [String] = []

        for key in parameters!.keys.sorted() {
            let value = parameters![key] ?? ""
            let stringValue = "\(value)"
            let encoded = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(key)=\(encoded)")
        }
        
        let formString = parts.joined(separator: "&")

        return formString.data(using: .utf8)
    }
}

// MARK: - Show My Request
struct ShowMyRequestForUser: APIRequest {
    typealias Response = APIResponse<[TripDetailResponse]>
    var path: String { "api/showMyRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    let driver: String?
    
    var parameters: [String: String]? {
        return  [
            "token": token,
            "driver": driver ?? ""
        ]
    }
    
    var body: Data? {
        var parts: [String] = []

        for key in parameters!.keys.sorted() {
            let value = parameters![key] ?? ""
            let stringValue = "\(value)"
            let encoded = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(key)=\(encoded)")
        }
        
        let formString = parts.joined(separator: "&")

        return formString.data(using: .utf8)
    }
}


// MARK: - Show My Request
struct ShowMyRequestForDriver: APIRequest {
    typealias Response = APIResponse<[TripDetailResponse]>
    var path: String { "api/showMyRequest" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var parameters: [String: String]? {
        return  [
            "token": token,
        ]
    }
    
    var body: Data? {
        var parts: [String] = []

        for key in parameters!.keys.sorted() {
            let value = parameters![key] ?? ""
            let stringValue = "\(value)"
            let encoded = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(key)=\(encoded)")
        }
        
        let formString = parts.joined(separator: "&")

        return formString.data(using: .utf8)
    }
}



// MARK: - Driver Arrived
struct DriverArrivedRequest: APIRequest {
    typealias Response = APIResponse<TripData>
    var path: String { "api/driverArrived" }
    var method: HTTPMethod { .get }
    
    let token: String
    let tripId: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "tripId", value: tripId)
        ]
    }
}

// MARK: - Change Status
struct ChangeStatusRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/changeStatus" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let status: String
    
    var body: Data? {
        let dic : [String : Any] = [
            "token": token,
            "tripId": tripId,
            "status": status
        ]
        return dic.toFormURLEncodedData()
    }
}

// MARK: - Show Trip Detail
struct ShowTripDetailRequest: APIRequest {
    typealias Response = APIResponse<TripDetail>
    var path: String { "api/showTripDetail" }
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

// MARK: - Show Distance
struct ShowDistanceRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/showDistance" }
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






extension Dictionary where Key == String, Value == Any {
    /// Converts a dictionary into `application/x-www-form-urlencoded` data.
    func toFormURLEncodedData() -> Data? {
        var parts: [String] = []

        for key in self.keys.sorted() {
            let value = self[key] ?? ""
            let stringValue = "\(value)"
            let encoded = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            parts.append("\(key)=\(encoded)")
        }

        let formString = parts.joined(separator: "&")
        return formString.data(using: .utf8)
    }
}
