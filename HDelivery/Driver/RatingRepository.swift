//
//  RatingRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// RatingRepository.swift

import Foundation

protocol RatingRepository {
    func rateDriver(token: String, tripId: String, rate: String) async throws -> APIResponse<String>
    func ratePassenger(token: String, tripId: String, rate: String) async throws -> APIResponse<String>
}

final class APIRatingRepository: RatingRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func rateDriver(token: String, tripId: String, rate: String) async throws -> APIResponse<String> {
        try await network.execute(RateDriverRequest(token: token, tripId: tripId, rate: rate))
    }
    
    func ratePassenger(token: String, tripId: String, rate: String) async throws -> APIResponse<String> {
        try await network.execute(RatePassengerRequest(token: token, tripId: tripId, rate: rate))
    }
}
