
//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 04/11/25.
//

import Foundation



// MARK: - State Model
struct States: Codable, Identifiable {
    let id: String
    let stateName: String
    let stateCities: [City]

    enum CodingKeys: String, CodingKey {
        case id = "stateId"
        case stateName
        case stateCities
    }

    // Custom decode init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        stateName = try container.decode(String.self, forKey: .stateName)
        stateCities = try container.decodeIfPresent([City].self, forKey: .stateCities) ?? []
    }
}

// MARK: - City Model (empty for now)
struct City: Codable {
    // Update fields here if stateCities later contain data
}
