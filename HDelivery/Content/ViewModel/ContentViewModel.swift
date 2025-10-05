//
//  ContentViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
     init() {
        Task {
            await self.gernalSettings()
        }
    }
    
    func gernalSettings() async {
        let repository =  AppDependencies.shared.makeUtilityRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let request = try await repository.generalSettings(token: token)
            if request.isSuccess {
               let appSettings = request.data
                let link_type = request.listJob.first?.link
                Task {
                  await showUserInfo()
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        
    }
    
    func showUserInfo() async  {
        let repository =  AppDependencies.shared.makeUserRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let request = try await repository.showUserInfo(token: token)
            if request.isSuccess {
                
                let isDriver = StorageManager.shared.isDriver()
                if isDriver {
                    Task {
                     await showMyTripHistoryDriver() // check online
                    }
                }
                else {
                    Task {
                      await  checkOnlineUser() // check online user
                    }
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    
    // for driver
    func showMyTripHistoryDriver() async {   // check driver online
        let repository =  AppDependencies.shared.makeTripRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
        
            let request = try await repository.showMyDriverRequests(token: token) // page -> 1 is defualt
            if request.isSuccess {
                let tripData = request.data ?? []
                if tripData.count > 0 {
                    let tripStaus = tripData[0].status
                    let  passengerRate =  tripData[0].passengerRate ?? "0"
                    
                    if tripData[0].isWattingConfirm == "1" {
                        // Move to Request Screen
                        
                    }
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
   
    func checkOnlineUser() async  {   // check user online
        let repository =  AppDependencies.shared.makeTripRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
        
            
            let request = try await  repository.showMyUserRequests(token: token, driver: "0")
            if request.isSuccess {
               if  let tripData = request.data, tripData.count > 0 {
                   let tripId  = tripData[0].id
                   let tripStaus = tripData[0].status  //
                    
                   
                   // Go To -> Request Send
                   
                }
                  
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }

    
}
