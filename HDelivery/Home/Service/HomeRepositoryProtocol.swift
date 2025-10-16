//
//  HomeRepositoryProtocol.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//


import Foundation
import Combine


protocol HomeRepositoryProtocol {
    func makeRequest(with tripRequest: CreateTripRequestAPIRequest) -> AnyPublisher<Int, Error>
   
}


class HomeRepository: HomeRepositoryProtocol {
    
    private let apiClient: NetworkClient
    
    init (apiClient: NetworkClient) {
        self.apiClient =  apiClient
    }
    
    
    func makeRequest(with tripRequest: CreateTripRequestAPIRequest) -> AnyPublisher<Int, any Error> {
        
        return apiClient.executePublisher(tripRequest)
            .handleEvents(receiveOutput: { response in
                print("Items API Response: \(response)")
            })
            .map { response in
                return response
            }
            .catch { error -> AnyPublisher<Int, Error> in
                print("Items API Error: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
}
