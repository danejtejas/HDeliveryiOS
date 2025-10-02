//
//  ItemService.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import Combine
import Foundation

// MARK: - API Request Models

struct ItemRequest: APIRequest {
    typealias Response = ItemResponse
    let method: HTTPMethod = .get
    var jobType: String = "delivery"
    
    var path: String {
        return "items"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "job_type", value: String(jobType))]
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
}

struct ItemResponse: Codable {
    let success: Bool
    let message: String?
    let data: [Item]?
    let items: [Item]?
    
    // Handle different possible response structures
    var itemList: [Item] {
        return data ?? items ?? []
    }
}

// MARK: - Item Service

class ItemService {
    
    static let shared = ItemService()
    private let repository: ItemRepositoryAPI
    
    // Default initializer uses production repository
    private init() {
        self.repository = ItemRepositoryAPI(networkClient: APIService(baseURL: AppSetting.URLS.baseURL))
    }
    
    // Initializer for dependency injection (useful for testing)
    init(repository: ItemRepositoryAPI) {
        self.repository = repository
    }
    
    // MARK: - Public Methods
    
    /// Fetch items by job type
    func getItems(jobId: Int) -> AnyPublisher<[Item], Error> {
        let request = ItemRequest(jobType: "pickup")
        return repository.getItems(itemRequest: request)
    }
    
    /// Fetch items with ItemRequest
    func getItems(itemRequest: ItemRequest) -> AnyPublisher<[Item], Error> {
        return repository.getItems(itemRequest: itemRequest)
    }
    
    /// Fetch all items (default job type)
    func getAllItems() -> AnyPublisher<[Item], Error> {
        return getItems(jobId: 10) // Default job type
    }
}
