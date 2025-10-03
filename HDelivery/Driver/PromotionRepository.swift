//
//  PromotionRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// PromotionRepository.swift

import Foundation

protocol PromotionRepository {
    func showMyCode(userId: String) async throws -> APIResponse<String>
    func applyPromo(userId: String, promoCode: String) async throws -> APIResponse<String>
    func getIntroduction() async throws -> APIResponse<String>
}

final class APIPromotionRepository: PromotionRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func showMyCode(userId: String) async throws -> APIResponse<String> {
        try await network.execute(ShowMyCodeRequest(userId: userId))
    }
    
    func applyPromo(userId: String, promoCode: String) async throws -> APIResponse<String> {
        try await network.execute(ApplyPromoCodeRequest(userId: userId, promoCode: promoCode))
    }
    
    func getIntroduction() async throws -> APIResponse<String> {
        try await network.execute(GetIntroductionRequest())
    }
}
