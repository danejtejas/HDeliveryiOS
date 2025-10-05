//
//  AppDependencies.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

import Foundation
import Combine

final class AppDependencies {
    static let shared = AppDependencies()
    private let apiService: NetworkClient
    
    private init() {
        self.apiService = APIService(baseURL: "https://hapihyper.com/admin/")
    }
    
//    func makeAuthRepository() -> AuthRepository { APIAuthRepository(network: apiService) }
    func makeUserRepository() -> UserRepository { APIUserRepository(network: apiService) }
    func makeDriverRepository() -> DriverRepository { APIDriverRepository(network: apiService) }
    func makeTripRepository() -> TripRepository {
        return  APITripRepository(network: apiService)
    }
    func makePaymentRepository() -> PaymentRepository { APIPaymentRepository(network: apiService) }
    func makeHistoryRepository() -> HistoryRepository { APIHistoryRepository(network: apiService) }
    func makeRatingRepository() -> RatingRepository { APIRatingRepository(network: apiService) }
    func makeUtilityRepository() -> UtilityRepository { APIUtilityRepository(network: apiService) }
    func makePromotionRepository() -> PromotionRepository { APIPromotionRepository(network: apiService) }
    func makeSignatureRepository() -> SignatureRepository { APISignatureRepository(network: apiService) }
    func makeRequestRepository() -> RequestRepository { APIRequestRepository(network: apiService) }
}
