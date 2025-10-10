//
//  PaymentAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// PaymentAPI.swift
// Payment related API requests

import Foundation

// MARK: - Trip Payment
struct TripPaymentRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/tripPayment" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let paymentMethod: String
    
    var body: Data? {
        let dic : [String : Any] = [
            "token": token,
            "tripId": tripId,
            "paymentMethod": paymentMethod
        ]
        return dic.toFormURLEncodedData()
    }
}

// MARK: - Driver Confirm Payment
struct DriverConfirmPaymentRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/driverConfirmPaymentTrip" }
    var method: HTTPMethod { .post }
    
    let tripId: String
    let paymentMethod: String // should be "2" for cash
    let action: String        // "1" confirm, "0" cancel
    let token : String
    
    
    var body: Data? {
        let dic : [String : Any] = ["tripId": tripId, "paymentMethod": paymentMethod, "action": action ,"token": token]
        return dic.toFormURLEncodedData()
    }
}

// MARK: - Point Exchange (Deposit)
struct PointExchangeRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/pointExchange" }
    var method: HTTPMethod { .post }
    
    let token: String
    let amount: String
    let transactionId: String
    let paymentMethod: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "amount": amount,
            "transactionId": transactionId,
            "paymentMethod": paymentMethod
        ])
    }
}

// MARK: - Point Redeem (Withdraw)
struct PointRedeemRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/pointRedeem" }
    var method: HTTPMethod { .post }
    
    let token: String
    let amount: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "amount": amount
        ])
    }
}

// MARK: - Point Transfer
struct PointTransferRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/pointTransfer" }
    var method: HTTPMethod { .post }
    
    let token: String
    let amount: String
    let receiverEmail: String
    let note: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "amount": amount,
            "receiverEmail": receiverEmail,
            "note": note
        ])
    }
}

// MARK: - Search User for Transfer
struct SearchUserRequest: APIRequest {
    typealias Response = APIResponse<UserInfo>
    var path: String { "api/searchUser" }
    var method: HTTPMethod { .post }
    
    let token: String
    let email: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "email": email
        ])
    }
}

// MARK: - Stripe Payment Request
struct StripePaymentRequest: APIRequest {
    typealias Response = String // Stripe returns HTML/redirect, not JSON
    var path: String { "stripe/web/index.php" }
    var method: HTTPMethod { .get }
    
    let token: String
    let amount: String
    let email: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "amount", value: amount),
            URLQueryItem(name: "email", value: email)
        ]
    }
}

