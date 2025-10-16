//
//  DriverRateViewModel.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//


import Foundation
import Combine
import SwiftUI



@MainActor
class UserRateViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var isSuccess = false
    
    private let repository: RatingRepository
    
    init(repository: RatingRepository = AppDependencies.shared.makeRatingRepository()) {
        self.repository = repository
    }
    
    func ratePassenger(tripId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let response = try await repository.rateDriver(token: token, tripId: tripId, rate: "9")
            print("response: \(response)")
            
            message = response.message
            isSuccess = response.isSuccess
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
        }
    }
}

