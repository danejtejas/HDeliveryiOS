//
//  PromotionsViewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine

@MainActor
class PromotionsViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var error : String?
    @Published var isShowAlert : Bool = false
    
    func applyPromoCodeRequest(code : String) async {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            
            try ValidationManager.shared.validate(fields: ["Promo Code" : (value: code, rules: [RequiredRule(fieldName:"Promo Code" )])])
            
            
            let rep = AppDependencies.shared.makePromotionRepository()
            guard let  userId = try StorageManager.shared.getUserId() else {
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
        }
        isShowAlert = true
    }
    
}
