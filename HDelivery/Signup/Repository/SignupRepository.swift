//
//  SignupRepository.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//


import SwiftUI
import Combine




protocol SignupRepositoryProtocol {
    func signup(createSingupRequest: CreateSignupRequestAPIRequest) -> AnyPublisher<Int, Error>
    
}



struct CreateSignupRequestAPIRequest: APIRequest {
    typealias Response = Int
    
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



struct SignupRepository: SignupRepositoryProtocol {
    
    private var networkClient :  NetworkClient
       
    init (networkClient :  NetworkClient) {
        self.networkClient = networkClient
    }
    
    
    func signup(createSingupRequest: CreateSignupRequestAPIRequest) -> AnyPublisher<Int, any Error> {
    
        return  self.networkClient.executePublisher(createSingupRequest)
            .handleEvents(receiveOutput: { response in
                print("Items API Response: \(response)")
            })
            .map { response in
                return response
            }
            .catch { error -> AnyPublisher<Int, Error> in
                print("Items API Error: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        
    }
    
//    func testSingup(createSingupRequest: CreateSignupRequestAPIRequest) async throws -> APIResponse<Int> {
//      return  try self.networkClient.execute(createSingupRequest)
//    }
    
}
