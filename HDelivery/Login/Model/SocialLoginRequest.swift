//
//  SocailLogin.swift
//  HDelivery
//
//  Created by Tejas on 05/11/25.
//


import Foundation

struct SocialLoginRequest: APIRequest {
    typealias Response = APIResponse<UserData>
    
    var path: String { "api/login" }
    var method: HTTPMethod { .post }
    
    let gcm_id: String
    let email: String
    let ime: String
    let type: String   // "1" = Android, "2" = iOS
    let lat: String
    let long: String
    let name: String
    let gender: String
    let image: String
    
    var body: Data? {
        let params: [String: Any] = [
            "gcm_id": gcm_id,
            "email": email,
            "ime": ime,
            "type": type,
            "lat": lat,
            "long": long,
            "name": name,
            "gender": gender,
            "image": image
        ]
        
        // Convert to application/x-www-form-urlencoded
        return params.toFormURLEncodedData()
    }
}
