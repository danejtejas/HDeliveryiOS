//
//  PayoutViewModel.swift
//  HDelivery
//
//  Created by Tejas on 11/10/25.
//

import SwiftUI


@MainActor
class PayoutViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var newBalance: String?
    @Published var redeemedPoints: String?
    @Published var isSuccess = false
    
    private let repository: PaymentRepository
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
    }
    
    func redeemPoints( amount: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let response = try await repository.pointRedeem(token: token , amount: amount)
            message = response.message
            if response.isSuccess {
                isSuccess = true
                
            }
            else
            {
                print("error message: \(String(describing: response.message))")
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}
