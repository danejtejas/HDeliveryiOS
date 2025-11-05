//
//  APIGoogleLoging.swift
//  HDelivery
//
//  Created by Tejas on 05/11/25.
//


import Foundation

protocol SocailLogin {
    func Login(request : any APIRequest) async throws -> APIResponse<UserData>?
}

final class APIGoogleLoging: SocailLogin {
    
    let networkService: NetworkClient
    
    init(networkService: NetworkClient) {
        
        self.networkService = networkService
    }
    
    func Login(request: any APIRequest) async throws -> APIResponse<UserData>? {
        return try await networkService.execute(request) as? APIResponse<UserData> ?? nil
    }
    
  

}

