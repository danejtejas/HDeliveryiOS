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
        !username.isEmpty && !password.isEmpty
    }

    func login(loginModel : LoginModel) {
        guard isValid else { return }
        
        isLoading = true
        error = nil
        

//        LoginService.shared.login(username: username, password: password)
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
//                self?.isLoggedIn = success
//            }
//            .store(in: &cancellables)
    }
}
