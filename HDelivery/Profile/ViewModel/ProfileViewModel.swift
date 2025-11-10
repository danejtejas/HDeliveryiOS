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
    @Published var make  : String?
    
    @Published var rating : Double? = 0
    
    @Published var taskType : String = "Task Type"
    
    @Published var typeAccount : String = ""
    
    
     func fetchData() {
        let url = URL(string: StorageManager.shared.getUserInfo()?.image ?? "")
        prfileImageUrl = url
        fullName = StorageManager.shared.getUserInfo()?.fullName ?? ""
        
        
        email = StorageManager.shared.getUserInfo()?.email ?? ""
        phone = StorageManager.shared.getUserInfo()?.phone ?? ""
        cityName = StorageManager.shared.getUserInfo()?.cityName ?? ""
        
        typeAccount = StorageManager.shared.getUserInfo()?.typeAccount ?? ""
        
        rating = Double(StorageManager.shared.getUserInfo()?.passengerRate ?? "0")
        
        address = StorageManager.shared.getUserInfo()?.address
         state =  StorageManager.shared.getUserInfo()?.stateName ?? ""
        cityName = StorageManager.shared.getUserInfo()?.cityName
        
        let arr =  StorageManager.shared.getUserInfo()?.account?.split(separator: "*") ?? []
        if arr.count >= 1 {
            bankName = String(arr[0])
        }
        if arr.count >= 2 {
            bankACNumber = String(arr[1])
        }
        
        
        if  let driver = StorageManager.shared.getUserInfo()?.driver {
            postCode = ""
            let arr = driver.bankAccount?.split(separator: "*") ?? []
            if arr.count >= 1 {
                bankName = String(arr[0])
            }
            if arr.count >= 2 {
                bankACNumber = String(arr[1])
            }
            rating = Double(driver.driverRate ?? "0")
        }
        
        if let car = StorageManager.shared.getUserInfo()?.car {
            carPlate = car.carPlate ?? ""
            yearOfManufacture = car.year
            make = car.model ?? ""
            
        }
    }
    
   
    
    func updateProfile(){
        
        
    }
    
}
