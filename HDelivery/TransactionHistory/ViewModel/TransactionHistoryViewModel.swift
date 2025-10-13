//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI

@MainActor
class TransactionHistoryViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var transactions: [Transaction] = []
    @Published var message: String?
    @Published var isSuccess = false

    private let repository: HistoryRepository

    init(repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()) {
        self.repository = repository
    }

    func loadTransactions() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTransactionHistory(token:token , page: "1")
            message = response.message
            if response.isSuccess {
                transactions = response.data ?? []
                isSuccess = true
            } else {
                isSuccess = false
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}
