//
//  PromotionAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// Promotion & referral related API requests

import Foundation

// MARK: - Show My Code
struct ShowMyCodeRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/showMyCode" }
    var method: HTTPMethod { .get }
    
    let userId: String
    
    var queryItems: [URLQueryItem]? {
        [URLQueryItem(name: "user_id", value: userId)]
    }
}

// MARK: - Apply Promo Code
struct ApplyPromoCodeRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/ApplyPromo" }
    var method: HTTPMethod { .get }
    
    let userId: String
    let promoCode: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "user_id", value: userId),
            URLQueryItem(name: "promocode", value: promoCode)
        ]
    }
}

// MARK: - Get App Introduction
struct GetIntroductionRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/instruction" }
    var method: HTTPMethod { .get }
    
    // No parameters required
}
