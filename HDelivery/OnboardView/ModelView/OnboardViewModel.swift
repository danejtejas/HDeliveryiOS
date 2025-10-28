//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 23/10/25.
//

import SwiftUI

@MainActor
class OnboardViewModel:  ObservableObject {
    
   @Published var msg: String? = nil
    
   @Published var   items: [OnboardingItem] = []
    
  private var  respository:  PromotionRepository
    
    init (respository:  PromotionRepository = AppDependencies.shared.makePromotionRepository()) {
        self.respository = respository
    }
    
    
    func getData() async  {
        
         do {
             let request = try await respository.getIntroduction()
               msg = request.message
             items = (request.data ?? []) ?? []
             
         }catch{
             print("error ==> \(error)")
         }
        
    }
    
    
}





