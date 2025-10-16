//
//  RatingAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


// Rating related API requests

import Foundation

// MARK: - Rate Driver
struct RateDriverRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/rateDriver" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let rate: String
    
    var body: Data? {
        let dic: [String : Any] = [
            "token": token,
            "tripId": tripId,
            "rate": rate
        ]
        return dic.toFormURLEncodedData()
    }
}

// MARK: - Rate Passenger
struct RatePassengerRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/ratePassenger" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let rate: String
    
    var body: Data? {
        let dic: [String : Any] = [
            "token": token,
            "tripId": tripId,
            "rate": rate
        ]
        return dic.toFormURLEncodedData()
    }
}
