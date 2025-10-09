//
//  LiveLocationModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine

class LiveLocationViewModel: ObservableObject {
    
    
    func driverArrivedRequest(_ tripId: String) async  {  //
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.driverArrived(token: token, tripId: tripId)
            if  response.isSuccess{
                print(response)
             }
             else {
                 print(response.message ?? "")
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
        }
    }
    
    func changeTripRequest(_ tripId: String) async  {
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.changeStatus(token: token, tripId: tripId , status: TripStatus.arrivedB.rawValue)
            if  response.isSuccess{
                print(response)
             }
             else {
                 print(response.message ?? "")
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
        }
    }
    
}
