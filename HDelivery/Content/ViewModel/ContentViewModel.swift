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
                     await showMyTripHistoryDriver()
                    }
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    
    // for driver
    func showMyTripHistoryDriver() async {
        let repository =  AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let request = try await repository.getTripHistory(token: token, page: "1") // page -> 1 is defualt
            if request.isSuccess {
                let tripData = request.data ?? []
                if tripData.count > 0 {
                   if tripData[0].isWattingConfirm == 1 {
                        // Move to Request Screen
                    }
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
