//
//  DriverRateViewModel.swift
//  HDelivery
//
//  Created by Tejas on 10/10/25.
//

import SwiftUI

@MainActor
class DriverRateViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var isSuccess = false
    
    private let repository: RatingRepository
    
    init(repository: RatingRepository = AppDependencies.shared.makeRatingRepository()) {
        self.repository = repository
    }
    
    func ratePassenger(tripId: String, rate: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let response = try await repository.ratePassenger(token: token, tripId: tripId, rate: rate)
            print("response: \(response)")
            
            message = response.message
            isSuccess = response.isSuccess
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}
