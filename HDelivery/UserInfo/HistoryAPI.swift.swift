//
//  HistoryAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// HistoryAPI.swift
// Trip & Transaction history API requests

import Foundation

// MARK: - Trip History
struct TripHistoryRequest: APIRequest {
    typealias Response = APIResponse<[TripHistory]>
    var path: String { "api/showMyTrip" }
    var method: HTTPMethod { .post }
    
    let token: String
    let page: String
    
    var body: Data? {
        
        let string = "token=\(token)&page=\(page)"
        let data = string.data(using: .utf8)!
        return data
//        try? JSONEncoder().encode([
//            "token": token,
//            "page": page
//        ])
    }
}

// MARK: - Transaction History
struct TransactionHistoryRequest: APIRequest {
    typealias Response = APIResponse<[MockTransactionInfo]>
    var path: String { "api/transactionHistory" }
    var method: HTTPMethod { .post }
    
    let token: String
    let page: String
    
    var body: Data? {
        let dic : [String:Any] =  [
            "token": token,
            "page": page
        ]
        return dic.toFormURLEncodedData()
    }
}

struct MockTransactionInfo: Codable {
    let id: String
    let amount: String
    let method: String
    let date: String
    let description: String?
}
