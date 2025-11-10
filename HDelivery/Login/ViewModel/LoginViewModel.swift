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
    @Published var error: String = ""
    @Published var loginModel : LoginModel?
    @Published var isShowToast: Bool = false

    private var cancellables = Set<AnyCancellable>()
     var loginRequest : LoginRequest?
    
    func login(email : String, password : String) {
        defer {
            isLoading = false
        }
        
       
        error = ""
        isShowToast = false
        
        let  getFCMToken = try? StorageManager.shared.getFCMToken() ?? ""
        
        
        let emailId =  email   //"rutvikdemo2@gmail.com"
        let gcm_id = getFCMToken
        let ime  = "123456"
        let pass =  password //"Rutvik123@"
        let lat  =   "0.0"
        let long =  "0.0"
    
        
        let loginRequest =  LoginRequest(email: emailId, gcm_id: gcm_id!, ime: ime, password: pass, lat: lat, long: long)
        self.loginRequest = loginRequest
        
        do{
            
            try validation()
            isLoading = true
        }
        catch {
            self.error = error.localizedDescription
            self.isShowToast = true
            return
        }
        
        LoginService.shared.login(loginRequest: loginRequest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    self?.error = err.localizedDescription
                    self?.isShowToast = true
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
                        self?.error = error.localizedDescription
                        self?.isShowToast = true
                    }
                    
                    
                } else {
                    self?.error = response.message
                    self?.isShowToast = true
                }
            }
            .store(in: &cancellables)
    }
    
    
    
    func validation() throws {
        
        
        let fildOrder : [String] = ["Email","Password"]
        
       try ValidationManager.shared.validate(fields:
                                            ["Email" : (value: loginRequest?.email,
                                                        rules: [RequiredRule(fieldName: "Email"),
                                                                EmailRule()]) ,
                                             "Password" : (value: loginRequest?.password,
                                                           rules: [ RequiredRule(fieldName: "Password"),
                                                                  PasswordRule()])],
                                             fieldOrders: fildOrder)
        
    }
        
}
