//
//  ProfileViewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {

    @Published var prfileImageUrl : URL?
   
    @Published var fullName : String?
    @Published var bankName: String = ""
    @Published var bankACNumber : String?
 
   
 
  
   
    @Published var postCode : String?
    @Published var state: String = ""
   
    @Published var address : String?
    @Published var email: String = ""
   
    @Published var phone : String?
    @Published var cityName : String?
      
     
     init() {
         let url = URL(string: StorageManager.shared.getUserInfo()?.image ?? "")
         prfileImageUrl = url
         fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
         
         
         email = StorageManager.shared.getUserInfo()?.email ?? ""
         phone = StorageManager.shared.getUserInfo()?.phone ?? ""
         cityName = StorageManager.shared.getUserInfo()?.cityName ?? ""
         postCode = "222"
         bankName = ""
         bankACNumber = ""
     }
    
    func updateProfile(){
        
        
    }
    
}
