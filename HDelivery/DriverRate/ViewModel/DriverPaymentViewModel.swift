//
//  DriverPaymentViewModel.swift
//  HDelivery
//
//  Created by Tejas on 10/10/25.
//


import SwiftUI


@MainActor
class DriverPaymentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var isSuccess = false
    
    private let repository: PaymentRepository
    @Published var showToashMessage: Bool = false
    
    init(repository: PaymentRepository = AppDependencies.shared.makePaymentRepository()) {
        self.repository = repository
    }
    
     func confirmDriverPayment(tripId: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""

            let response = try await repository.driverConfirmPayment(token: token, tripId: tripId, paymentMethod: "2", action: "1")
            print("response: \(response)")

            message = response.message
            isSuccess = response.isSuccess
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
         showToashMessage = true
    }
}
