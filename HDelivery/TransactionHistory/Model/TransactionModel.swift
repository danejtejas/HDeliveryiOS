//
//  TransactionModel.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//


import SwiftUI






struct Transaction: Codable, Identifiable {
    let id: String
    let userId: String
    let type: String
    let amount: String
    let action: String
    let destination: String?
    let tripId: String?
    let dateCreated: String
    let paymentMethod: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case type
        case amount
        case action
        case destination
        case tripId
        case dateCreated
        case paymentMethod
    }
    
    enum PaymentType: String {
        case cash = "2"
        case wallet = "1"
        case unknowe = ""
        
        var display: String {
            switch self {
            case .cash:
                return "Cash"
            case .wallet:
                return "Wallet"
            default:
                return ""
            }
        }
    }
   
    
    
    var isNegative: Bool {
        return  self.type == "-"
    }
    
    var paymentMethodDisplay: String {
        return PaymentType(rawValue:paymentMethod)?.display ?? ""
        
    }
    
    
    
}
