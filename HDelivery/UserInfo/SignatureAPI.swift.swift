//
//  SignatureAPI.swift.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// SignatureAPI.swift
// Receiver signature and delivery confirmation APIs

import Foundation

// MARK: - Receiver Signature
struct ReceiverSignatureRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/receiverdate" }
    var method: HTTPMethod { .post }
    
    let token: String
    let tripId: String
    let username: String
    let transactionId: String
    let userId: String
    let image: String              // Base64 encoded receiver photo
    let receiverSignature: String  // Base64 encoded signature
    
    var body: Data? {
        try? JSONEncoder().encode([
            "token": token,
            "tripId": tripId,
            "username": username,
            "transection_id": transactionId,
            "user_id": userId,
            "image": image,
            "receiver_signature": receiverSignature
        ])
    }
}
