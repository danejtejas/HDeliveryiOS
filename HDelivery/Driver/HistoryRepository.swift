//
//  HistoryRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// HistoryRepository.swift

import Foundation

protocol HistoryRepository {
    func getTripHistory(token: String, page: String) async throws -> APIResponse<[TripHistory]>
    func getTransactionHistory(token: String, page: String) async throws -> APIResponse<[Transaction]>
}

final class APIHistoryRepository: HistoryRepository {
   
    
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func getTripHistory(token: String, page: String) async throws -> APIResponse<[TripHistory]> {
        try await network.execute(TripHistoryRequest(token: token, page: page))
    }
    
    
    func getTransactionHistory(token: String, page: String) async throws -> APIResponse<[Transaction]> {
        try await network.execute(TransactionHistoryRequest(token: token, page: page))
    }
}
