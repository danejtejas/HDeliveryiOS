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
      
    
    @Published var carPlate : String?
    @Published var yearOfManufacture : String?
    @Published  var  make  : String?
     
    
    @Published var taskType : String = "Task Type"
    
    
    
    
     init() {
         let url = URL(string: StorageManager.shared.getUserInfo()?.image ?? "")
         prfileImageUrl = url
         fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
         
         
         email = StorageManager.shared.getUserInfo()?.email ?? ""
         phone = StorageManager.shared.getUserInfo()?.phone ?? ""
         cityName = StorageManager.shared.getUserInfo()?.cityName ?? ""
         if  let driver = StorageManager.shared.getUserInfo()?.driver {
             postCode = ""
             let arr = driver.bankAccount?.split(separator: "*") ?? []
             if arr.count > 1 {
                 bankName = String(arr[0])
             }
             if arr.count > 2 {
                 bankACNumber = String(arr[1])
             }
        }
        
         if let car = StorageManager.shared.getUserInfo()?.car {
             let carPlate = car.carPlate ?? ""
             let yearOfManufacture = car.year
             let make = car.model ?? ""
             
         }
     }
    
    func updateProfile(){
        
        
    }
    
}
