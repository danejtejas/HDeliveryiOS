//
//  LoginViewModel.swift
//  HDelivery
//
//  Created by user286520 on 9/30/25.
//

import Foundation
import Combine


struct LoginModel {
    var email = ""
    var password = ""
    
}

class LoginViewModel: ObservableObject {
  
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var error: String?
    @Published var loginModel : LoginModel?

    private var cancellables = Set<AnyCancellable>()

    var isValid: Bool {
        return true
    }

    func login(email : String, password : String) {
        guard isValid else { return }
        
        isLoading = true
        error = nil
        
        let  getFCMToken = try? StorageManager.shared.getFCMToken() ?? ""
        
        
        var emailId =  email   //"rutvikdemo2@gmail.com"
        let gcm_id = getFCMToken
        let ime  = "123456"
        let pass =  password //"Rutvik123@"
        let lat  =   "0.0"
        let long =  "0.0"
        
        let loginRequest =  LoginRequest(email: emailId, gcm_id: gcm_id!, ime: ime, password: pass, lat: lat, long: long)
        
        LoginService.shared.login(loginRequest: loginRequest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    self?.error = err.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                
                self?.isLoggedIn = response.success
                if response.success {
                    // Handle successful login
                    print("Login successful: \(response.message)")
                    
                    do {
                        
                        try StorageManager.shared.storeAuthToken(response.data.token)
                        try StorageManager.shared.storeUserData(response.data)
                        print("token stored ===> \(response.data.token)" )
                      
                        
                    } catch {
                        print("error \(error.localizedDescription)")
                    }
                    
                    
                } else {
                    self?.error = response.message
                }
            }
            .store(in: &cancellables)
    }
        
}
