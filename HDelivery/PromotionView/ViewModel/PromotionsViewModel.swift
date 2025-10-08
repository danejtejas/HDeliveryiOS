//
//  PromotionsViewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine

class PromotionsViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var error : String?
    
    func applyPromoCodeRequest(code : String) async {
        isLoading = true
        do {
            let rep = AppDependencies.shared.makePromotionRepository()
            guard let  userId = try StorageManager.shared.getUserId() else {
                isLoading = false
                return
            }
            let response = try await  rep.applyPromo(userId: userId, promoCode: code)
            isLoading = false
            if  response.isSuccess {
            }else {
                print("Error => \(response.message)")
                error = response.message
            }
            
        }
        catch {
            print("Error => \(error.localizedDescription)")
            self.error = error.localizedDescription
            isLoading = false
        }
    }
    
}
