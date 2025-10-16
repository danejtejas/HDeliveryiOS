//
//  UtilityRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// UtilityRepository.swift

import Foundation

protocol UtilityRepository {
    func showCarTypes() async throws -> APIResponse<[String]>
    func showStateCity() async throws -> APIResponse<[String]>
//    func getItems(jobType: String) async throws -> APIResponse<[String]>
    func generalSettings(token: String) async throws -> SettingsResponse
    func shareApp(token: String, type: String, social: String) async throws -> APIResponse<String>
    func needHelp(token: String, tripId: String) async throws -> APIResponse<String>
}

final class APIUtilityRepository: UtilityRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func showCarTypes() async throws -> APIResponse<[String]> {
        try await network.execute(ShowCarTypesRequest())
    }
    
    func showStateCity() async throws -> APIResponse<[String]> {
        try await network.execute(ShowStateCityRequest())
    }
    

    func generalSettings(token: String) async throws -> SettingsResponse {
        try await network.execute(GeneralSettingsRequest(token: token))
    }
    
    func shareApp(token: String, type: String, social: String) async throws -> APIResponse<String> {
        try await network.execute(ShareAppRequest(token: token, type: type, social: social))
    }
    
    func needHelp(token: String, tripId: String) async throws -> APIResponse<String> {
        try await network.execute(NeedHelpTripRequest(token: token, tripId: tripId))
    }
}
