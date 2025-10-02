//
//  ItemRepositoryAPI.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import Foundation
import Combine

// MARK: - Item Repository Protocol

protocol ItemRepositoryProtocol {
    func getItems(itemRequest: ItemRequest) -> AnyPublisher<[Item], Error>
    func getItemById(id: String) -> AnyPublisher<Item?, Error>
}

// MARK: - Item Repository Implementation

class ItemRepositoryAPI: ItemRepositoryProtocol {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getItems(itemRequest: ItemRequest) -> AnyPublisher<[Item], Error> {
        return networkClient.executePublisher(itemRequest)
            .handleEvents(receiveOutput: { response in
                print("Items API Response: \(response)")
            })
            .map { response in
                return response.itemList
            }
            .catch { error -> AnyPublisher<[Item], Error> in
                print("Items API Error: \(error)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getItemById(id: String) -> AnyPublisher<Item?, Error> {
        // This would be implemented if you have a specific item endpoint
        return Future<Item?, Error> { promise in
            // For now, return nil as this endpoint might not exist
            promise(.success(nil))
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Mock Repository for Testing

class MockItemRepository: ItemRepositoryProtocol {
    
    func getItems(itemRequest: ItemRequest) -> AnyPublisher<[Item], Error> {
        return Future<[Item], Error> { promise in
            // Simulate network delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let mockItems = [
                    Item(name: "Clothes", price: 120, description: "Clothing items"),
                    Item(name: "Pair of Shoes", price: 150, description: "Footwear"),
                    Item(name: "Hand Bags", price: 120, description: "Bags and accessories"),
                    Item(name: "Phones", price: 140, description: "Mobile devices"),
                    Item(name: "Laptop", price: 500, description: "Computing devices"),
                    Item(name: "Jewellery", price: 200, description: "Jewelry items"),
                    Item(name: "Toy", price: 200, description: "Toys and games"),
                    Item(name: "Wrist watch", price: 300, description: "Watches"),
                    Item(name: "Hair", price: 200, description: "Hair products"),
                    Item(name: "Hair care product", price: 150, description: "Hair care items")
                ]
                promise(.success(mockItems))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getItemById(id: String) -> AnyPublisher<Item?, Error> {
        return Future<Item?, Error> { promise in
            let mockItem = Item(name: "Mock Item", price: 100, description: "Mock item for testing")
            promise(.success(mockItem))
        }
        .eraseToAnyPublisher()
    }
}
