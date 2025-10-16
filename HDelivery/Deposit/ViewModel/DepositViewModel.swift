//
//  DepositViewModel.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI

@MainActor
class DepositViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var message: String?
    @Published var newBalance: String?
    @Published var exchangedPoints: String?
    @Published var isSuccess = false
    
    @Published var balance : String = "0"
    
    private let repository: PaymentRepository
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
        balance = StorageManager.shared.getUserInfo()?.balance ?? "0"
    }
    
    func exchangePoints(token: String, amount: String, exchangeType: String?, transactionId : String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await repository.pointExchange(token:token , amount: amount, transactionId: transactionId, paymentMethod: "3")
            
            message = response.message
            if response.status == "SUCCESS" {
                isSuccess = true
//                newBalance = response.data?.newBalance
//                exchangedPoints = response.data?.exchangedPoints
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}

