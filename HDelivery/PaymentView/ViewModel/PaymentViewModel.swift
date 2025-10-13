
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
    
    
    init() {
        balance = StorageManager.shared.getUserInfo()?.balance ?? "0"
        fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
    }
}
