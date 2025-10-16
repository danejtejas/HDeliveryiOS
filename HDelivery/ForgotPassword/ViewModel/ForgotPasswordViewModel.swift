//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI


protocol AuthRepository {
    func forgotPassword(email: String) async throws ->  APIResponse<String?>
}

final class APIAuthRepository: AuthRepository {
    private let network: NetworkClient
    
    init(network: NetworkClient) { self.network = network }
    
    func forgotPassword(email: String) async throws -> APIResponse<String?>  {
       
        try await network.execute(ForgotPasswordAPIRequest(email: email))
    }
}




@MainActor
class ForgotPasswordViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var isSuccess = false
    @Published var isShowAlert = false
    private let repository: AuthRepository
    
    init(repository: AuthRepository = AppDependencies.shared.makeAuthRepository()) {
        self.repository = repository
    }
    
    func forgotPassword(email: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await repository.forgotPassword(email: email)
            message = response.message
            isShowAlert = true
            isSuccess = (response.status == "SUCCESS")
            print(message)
        } catch {
           
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
            isShowAlert = true
            print("error == \(error.localizedDescription)")
        }
    }
}
