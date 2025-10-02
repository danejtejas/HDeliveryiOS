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
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var error: String?
    @Published var loginModel : LoginModel?

    private var cancellables = Set<AnyCancellable>()

    var isValid: Bool {
//        !username.isEmpty && !password.isEmpty
        true
    }

    func login() {
        guard isValid else { return }
        
        isLoading = true
        error = nil
        
        
        var email = "rutvikdemo2@gmail.com"
        var gcm_id = "d3QtXbH1RyiVWVMUogdpDd%3AAPA91bFMR9hwqGtSCqRX0osJOCF5rS7T_HlsdEiK20I5jT41pvhPjwmXVNSnKhZNiQCtXG6EyIs8OK7ILUsVbYeObPhrv0NiiSReTyK7VJFoLAaIn6ZRtEw"
        var ime  = "123456"
        var password = "Rutvik123@"
        var lat  = "0.0"
        var long = "0.0"
        
        let loginRequest =  LoginRequest(email: email, gcm_id: gcm_id, ime: ime, password: password, lat: lat, long: long)
        
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
                    print("Login successful: \(response.message ?? "")")
//                    if let user = response.user {
//                        print("Welcome, \(user.name ?? user.email)")
//                    }
                } else {
                    self?.error = response.message ?? "Login failed"
                }
            }
            .store(in: &cancellables)
    }
    
    /// Login with email and password directly
    func login(email: String, password: String) {
        let loginModel = LoginModel(email: email, password: password)
//        login(loginModel: loginModel)
    }
    
    /// Logout current user
//    func logout() {
//        isLoading = true
//        error = nil
//        
//        LoginService.shared.logout()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                self?.isLoading = false
//                switch completion {
//                case .failure(let err):
//                    self?.error = err.localizedDescription
//                case .finished:
//                    break
//                }
//            } receiveValue: { [weak self] success in
//                if success {
//                    self?.isLoggedIn = false
//                    self?.username = ""
//                    self?.password = ""
//                    self?.loginModel = nil
//                }
//            }
//            .store(in: &cancellables)
//    }
    
    /// Check if user is currently logged in
//    func checkLoginStatus() {
//        isLoggedIn = LoginService.shared.isLoggedIn()
//    }
}
