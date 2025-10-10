//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//

import SwiftUI


@MainActor
class UserPaymentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var isSuccess = false
    
    private let repository: PaymentRepository
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
    }
    
    
    func paymentRequest(tripId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let response = try await repository.tripPayment(token: token, tripId: tripId, paymentMethod: "2")
    
            print("response: \(response)")
        }catch {
            print("error => \(error)")
        }
    }
    
//    func confirmDriverPayment(tripId: String) async {
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            let token = try StorageManager.shared.getFCMToken() ?? ""
//            
//            let response = try await repository.driverConfirmPayment(token: token, tripId: tripId, paymentMethod: "2", action: "1")
//            print("response: \(response)")
//            
//            message = response.message
//            isSuccess = response.isSuccess
//        } catch {
//            message = "❌ \(error.localizedDescription)"
//            isSuccess = false
//        }
//    }
}
