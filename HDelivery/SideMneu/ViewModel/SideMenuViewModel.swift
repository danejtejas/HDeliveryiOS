//
//  SideMenuViewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI

class SideMenuViewModel : ObservableObject {

   @Published var prfileImageUrl : URL? 
   @Published var fullName : String?
    @Published var rate : Int = 0
     
    
    init() {
        let url = URL(string: StorageManager.shared.getUserInfo()?.image ?? "")
        prfileImageUrl = url
        fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
        rate = Int(StorageManager.shared.getUserInfo()?.passengerRate ?? "0") ?? 0
    }
    


}
