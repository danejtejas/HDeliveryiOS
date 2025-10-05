//
//  UserViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI
import Combine

@MainActor
class UserViewModel: ObservableObject {
    @Published var userInfo: UserInfo?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = AppDependencies.shared.makeUserRepository()) {
        self.userRepository = userRepository
    }
    
    func loadUserInfo() async {
        isLoading = true
        defer { isLoading = false }
        
        
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await userRepository.showUserInfo(token: token)
            if response.isSuccess, let data = response.data {
                self.userInfo = data
            } else {
                self.errorMessage = response.message ?? "Unknown error"
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
}
