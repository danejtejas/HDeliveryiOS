//
//  PaymentRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// PaymentRepository.swift

import Foundation

protocol PaymentRepository {
    func tripPayment(token: String, tripId: String, paymentMethod: String) async throws -> APIResponse<String>
    func driverConfirmPayment(tripId: String, paymentMethod: String, action: String) async throws -> APIResponse<String>
    func pointExchange(token: String, amount: String, transactionId: String, paymentMethod: String) async throws -> APIResponse<String>
    func pointRedeem(token: String, amount: String) async throws -> APIResponse<String>
    func pointTransfer(token: String, amount: String, receiverEmail: String, note: String) async throws -> APIResponse<String>
    func searchUser(token: String, email: String) async throws -> APIResponse<UserInfo>
    func stripePayment(token: String, amount: String, email: String) async throws -> String
}

final class APIPaymentRepository: PaymentRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func tripPayment(token: String, tripId: String, paymentMethod: String) async throws -> APIResponse<String> {
        try await network.execute(TripPaymentRequest(token: token, tripId: tripId, paymentMethod: paymentMethod))
    }
    
    func driverConfirmPayment(tripId: String, paymentMethod: String, action: String) async throws -> APIResponse<String> {
        try await network.execute(DriverConfirmPaymentRequest(tripId: tripId, paymentMethod: paymentMethod, action: action))
    }
    
    func pointExchange(token: String, amount: String, transactionId: String, paymentMethod: String) async throws -> APIResponse<String> {
        try await network.execute(PointExchangeRequest(token: token, amount: amount, transactionId: transactionId, paymentMethod: paymentMethod))
    }
    
    func pointRedeem(token: String, amount: String) async throws -> APIResponse<String> {
        try await network.execute(PointRedeemRequest(token: token, amount: amount))
    }
    
    func pointTransfer(token: String, amount: String, receiverEmail: String, note: String) async throws -> APIResponse<String> {
        try await network.execute(PointTransferRequest(token: token, amount: amount, receiverEmail: receiverEmail, note: note))
    }
    
    func searchUser(token: String, email: String) async throws -> APIResponse<UserInfo> {
        try await network.execute(SearchUserRequest(token: token, email: email))
    }
    
    func stripePayment(token: String, amount: String, email: String) async throws -> String {
        try await network.execute(StripePaymentRequest(token: token, amount: amount, email: email))
    }
}
