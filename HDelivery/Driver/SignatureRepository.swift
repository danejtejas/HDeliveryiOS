//
//  SignatureRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

// SignatureRepository.swift

import Foundation

protocol SignatureRepository {
    func uploadReceiverSignature(_ request: ReceiverSignatureRequest) async throws -> APIResponse<String>
}

final class APISignatureRepository: SignatureRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func uploadReceiverSignature(_ request: ReceiverSignatureRequest) async throws -> APIResponse<String> {
        try await network.execute(request)
    }
}
