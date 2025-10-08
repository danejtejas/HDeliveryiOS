//
//  LiveLocationModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine

class LiveLocationViewModel: ObservableObject {
    
    
    
    func driverArrivedRequest(_ tripId: String) async  {
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.driverArrived(token: token, tripId: tripId)
             
             
        } catch {
            print(error)
        }
    }
}
