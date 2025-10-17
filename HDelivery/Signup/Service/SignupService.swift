//
//  SignupService.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//


import Foundation
import Combine
import SwiftUI



class SignupService {
    
     let repository: SignupRepository
    
    init() {
        self.repository = SignupRepository(networkClient: APIService(baseURL: AppSetting.URLS.baseURL))
    }
    
    func signupRequest(singupModel : SignupModel) -> AnyPublisher<<APIResponse<String>,  Error>  {
        let createSingupRequest = CreateSignupRequestAPIRequest(singupModel: singupModel)
        return self.repository.signup(createSingupRequest: createSingupRequest)
        repository.signup(createSingupRequest: CreateSignupRequestAPIRequest(singupModel: singupModel))
    }
    
//    func singup(singupModel : SignupModel) -> APIResponse<String>{
//        return self.repository.signup(createSingupRequest: CreateSignupRequestAPIRequest(singupModel:singupModel ))
//    }
    
}
