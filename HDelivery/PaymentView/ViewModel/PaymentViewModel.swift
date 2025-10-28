
//
//  PaymentView.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//


import SwiftUI

class PaymentViewModel: ObservableObject {
    
    
    @Published  var balance: String?
    @Published var fullName: String?
    @Published var rateing : String = "0"
    
    
    init() {
        balance = StorageManager.shared.getUserInfo()?.balance ?? "0"
        fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
        rateing = StorageManager.shared.getUserInfo()?.passengerRate ?? "0"
    }
}
