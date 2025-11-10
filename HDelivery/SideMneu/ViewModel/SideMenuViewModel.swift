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
     
    @Published var menuItems : [MenuOption] =  MenuOption.allCases
        
    
    init() {
        let url = URL(string: StorageManager.shared.getUserInfo()?.image ?? "")
        prfileImageUrl = url
        fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
        rate = Int(StorageManager.shared.getUserInfo()?.passengerRate ?? "0") ?? 0
        let typeAccound = StorageManager.shared.getUserInfo()?.typeAccount ?? ""
        if typeAccound == "1" {
            
                menuItems = [
                    .home,
                    .profile,
                    .payment,
                    .share,
                    .help,
                    .online,
                    .tasksHistories,
                    .changePassword,
                    .myShareCode,
                    .promotions,
                    .terms,
                    .logout
                ]
        }
        else {
            
            menuItems = [
                .home,
                .profile,
                .payment,
                .share,
                .help,
                .asTasker,
                .tasksHistories,
                .changePassword,
                .myShareCode,
                .promotions,
                .terms,
                .logout
            ]
            
        }
      
      
        
    }
    


}
