//
//  SignupRepository.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//


import SwiftUI
import Combine



//
//protocol SignupRepositoryProtocol {
//    func signup(createSingupRequest: CreateSignupRequestAPIRequest) -> AnyPublisher<APIResponse<String>, Error>
//    
//}



struct CreateSignupRequestAPIRequest: APIRequest {
    typealias Response = APIResponse<String>
    
    var path: String = "signupAndroid"
    
    var method: HTTPMethod = .post
    var singupModel : SignupModel
    
    
    
    
    var parameters: [String: Any]?  {
        
        [
            "full_name": singupModel.fullName,
            "phone": singupModel.phone,
            "email": singupModel.email,
            "password": singupModel.password,
            "address": singupModel.address,
            "city": singupModel.city,
            "country": singupModel.country,
            "post_code": singupModel.postCode,
            "account": singupModel.account,
            "image" :  singupModel.imageData
        ] 
        
    }
    var body: Data? {
        let string =  "full_name=\(singupModel.fullName)&phone=\(singupModel.phone)&email=\(singupModel.email)&password=\(singupModel.password)&address=\(singupModel.address)&city=\(singupModel.city)&country=\(singupModel.country)&post_code=\(singupModel.postCode)&account=\(singupModel.account)&image=\(singupModel.imageData)"
        
        let data = string.data(using: .utf8)
        return data
        
    }
    
    
}



protocol SignupRepository {
    
    func signup(request:CreateSignupRequestAPIRequest) async throws -> APIResponse<String>
        


}


class APISignup: SignupRepository {
    
    let networkService: NetworkClient
    
    init(networkService: NetworkClient) {
        
        self.networkService = networkService
    }
    
    func signup(request: CreateSignupRequestAPIRequest) async throws -> APIResponse<String> {
        
        return   try await networkService.execute(request)
        
    }
    
    
}
