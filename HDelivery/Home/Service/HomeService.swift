//
//  HomeService.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//


import Foundation
import Combine

struct TripModel: Codable {
    let token: String
    let link: String
    let startLat: String
    let startLong: String
    let startLocation: String
    let endLat: String
    let endLong: String
    let endLocation: String
    let estimateDistance: String
    let items: [TripItem]

    enum CodingKeys: String, CodingKey {
        case token, link, startLat, startLong, startLocation, endLat, endLong, endLocation, estimateDistance
        case items = "item_id"
    }
    
    // Custom decoding for `item_id` because it's a stringified JSON array
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        token = try container.decode(String.self, forKey: .token)
        link = try container.decode(String.self, forKey: .link)
        startLat = try container.decode(String.self, forKey: .startLat)
        startLong = try container.decode(String.self, forKey: .startLong)
        startLocation = try container.decode(String.self, forKey: .startLocation)
        endLat = try container.decode(String.self, forKey: .endLat)
        endLong = try container.decode(String.self, forKey: .endLong)
        endLocation = try container.decode(String.self, forKey: .endLocation)
        estimateDistance = try container.decode(String.self, forKey: .estimateDistance)
        
        // Decode item_id as JSON string → [TripItem]
        let itemsString = try container.decode(String.self, forKey: .items)
        if let data = itemsString.data(using: .utf8) {
            items = try JSONDecoder().decode([TripItem].self, from: data)
        } else {
            items = []
        }
    }
}

struct TripItem: Codable {
    let id: Int
    let name: String
    let price: Int
}




struct CreateTripRequestAPIRequest: APIRequest {
    typealias Response = Int
    let path = "createRequest"
    let method: HTTPMethod = .post
    var tripModel: TripModel?
    
    var body: Data? {
        return try? JSONEncoder().encode(tripModel)
    }
    
    
}




struct HomeService  {
    
    let resository:  HomeRepository
    
    
    
    
}



