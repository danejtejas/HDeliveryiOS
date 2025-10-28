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
    @Published var isShowAlert = false
    private let repository: PaymentRepository
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
    }
    
    
    func paymentRequest(tripId: String, paymentMethod: paymentModeType) async {
        isLoading = true
        message = ""
        isShowAlert = false
        defer { isLoading = false }
        
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let response = try await repository.tripPayment(token: token, tripId: tripId, paymentMethod: "\(paymentMethod.rawValue)")
    
            print("response: \(response)")
            isShowAlert = true
            message = response.message
        }catch {
            print("error => \(error)")
            isShowAlert = true
            message = error.localizedDescription
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
