//
//  RequestRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// RequestRepository.swift

import Foundation

protocol RequestRepository {
    func deleteRequest(token: String) async throws -> APIResponse<String>
    func dismissRequest(token: String, requestId: String) async throws -> APIResponse<String>
}

final class APIRequestRepository: RequestRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func deleteRequest(token: String) async throws -> APIResponse<String> {
        try await network.execute(DeleteDriverRequest(token: token))
    }
    
    func dismissRequest(token: String, requestId: String) async throws -> APIResponse<String> {
        try await network.execute(DismissDriverRequest(token: token, requestId: requestId))
    }
}
