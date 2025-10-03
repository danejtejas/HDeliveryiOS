//
//  SignupViewModel.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import UIKit

class SignupViewModel: ObservableObject {
    
    @Published var signupModel: SignupModel = SignupModel()
    
    @Published var isLoading: Bool = false
        
    var signUpService: SignupService!
    
    init() {
        self.signUpService = SignupService()
    }
    
    
    func signup() {
        self.isLoading = true
        self.signUpService.signupRequest(singupModel: signupModel)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    print("Error: \(err)")
                case .finished:
                    print("Finished")
                }
                
            } receiveValue: { response in
               
                print("signup Successfully fetched \(response) items")
            }

        
    }
}
