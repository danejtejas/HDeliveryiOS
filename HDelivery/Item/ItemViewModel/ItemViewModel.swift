//
//  ItemViewModel.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import Foundation
import SwiftUI
import Combine

class ItemViewModel: ObservableObject {
    
    @Published var items: [Item] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var selectedItems: [Item] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let itemService: ItemService
    
    init(itemService: ItemService = ItemService.shared) {
        self.itemService = itemService
    }
    
    // MARK: - Public Methods
    
    /// Fetch items by job type
    func fetchItems(jobId: Int = 10) {
        isLoading = true
        error = nil
        
        itemService.getItems(jobId: jobId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    self?.error = err.localizedDescription
                    print("Failed to fetch items: \(err)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] deliverItems in
                self?.items = deliverItems.toItems()
//                self?.items = []
                print("Successfully fetched \(self?.items.count) items")
            }
            .store(in: &cancellables)
    }
    
    /// Fetch all items (default job type)
    func fetchAllItems() {
        fetchItems(jobId: 10)
    }
    
    /// Toggle item selection
    func toggleItemSelection(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isSelected.toggle()
            updateSelectedItems()
        }
    }
    
    /// Update item quantity
    func updateItemQuantity(_ item: Item, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = max(1, quantity)
            updateSelectedItems()
        }
    }
    
    /// Increment item quantity
    func incrementQuantity(for item: Item) {
        updateItemQuantity(item, quantity: item.quantity + 1)
    }
    
    /// Decrement item quantity
    func decrementQuantity(for item: Item) {
        updateItemQuantity(item, quantity: item.quantity - 1)
    }
    
    /// Calculate total price of selected items
    var totalPrice: Int {
        return selectedItems.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    
    /// Get count of selected items
    var selectedItemsCount: Int {
        return selectedItems.count
    }
    
    // MARK: - Private Methods
    
    private func updateSelectedItems() {
        selectedItems = items.filter { $0.isSelected }
    }
    
    /// Clear all selections
    func clearSelections() {
        for index in items.indices {
            items[index].isSelected = false
            items[index].quantity = 1
        }
        updateSelectedItems()
    }
    
    /// Retry fetching items
    func retry() {
        fetchAllItems()
    }
}



extension DeliveryItem {
    func toItem() -> Item {
        Item(
            id: self.id,
            name: self.name,
            price: Int(self.price) ?? 0,
            isSelected: false,
            description: "",     // fallback until API provides real description
            imageUrl: nil,          // can be filled if API provides image
            category: jobType,      // map jobType to category
            isAvailable: true
        )
    }
}

extension Array where Element == DeliveryItem {
    func toItems() -> [Item] {
        self.map { $0.toItem() }
    }
}
