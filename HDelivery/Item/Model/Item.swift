//
//  Item.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//
import Foundation

struct Item: Identifiable, Codable {
    let id: String
    var name: String
    var price: Int
    var isSelected: Bool = false
    var quantity: Int = 1
    var description: String
    var imageUrl: String?
    var category: String?
    var isAvailable: Bool = true
    
    // Custom coding keys if API response has different field names
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case description
        case imageUrl = "image_url"
        case category
        case isAvailable = "is_available"
        // Note: isSelected and quantity are UI-only properties, not from API
    }
    
    // Custom decoder to handle UI-only properties
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Int.self, forKey: .price)
        description = try container.decode(String.self, forKey: .description)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        isAvailable = try container.decodeIfPresent(Bool.self, forKey: .isAvailable) ?? true
        
        // UI-only properties with default values
        isSelected = false
        quantity = 1
    }
    
    // Custom encoder to handle UI-only properties
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encode(isAvailable, forKey: .isAvailable)
        
        // Note: isSelected and quantity are not sent to API
    }
    
    // Custom initializer for local use
    init(id: String = UUID().uuidString, 
         name: String, 
         price: Int, 
         isSelected: Bool = false, 
         quantity: Int = 1, 
         description: String, 
         imageUrl: String? = nil, 
         category: String? = nil, 
         isAvailable: Bool = true) {
        self.id = id
        self.name = name
        self.price = price
        self.isSelected = isSelected
        self.quantity = quantity
        self.description = description
        self.imageUrl = imageUrl
        self.category = category
        self.isAvailable = isAvailable
    }
}
