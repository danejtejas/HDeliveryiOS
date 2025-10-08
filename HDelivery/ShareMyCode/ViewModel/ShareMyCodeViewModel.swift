//
//  ShareMyCodeViewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI

class ShareMyCodeViewModel: ObservableObject {
    
    @Published var isLoading : Bool = false
    @Published var error : String?
    @Published var promotionCode : String?
    
    func shareCode() async {
        isLoading = true
        do {
            let rep = AppDependencies.shared.makePromotionRepository()
            guard let  userId = try StorageManager.shared.getUserId() else {
                isLoading = false
                return
            }
            let response = try await  rep.showMyCode(userId: userId)
            isLoading = false
            if  response.isSuccess {
                promotionCode = response.data ?? ""
            }else {
                print("Error => \(String(describing: response.message))")
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
