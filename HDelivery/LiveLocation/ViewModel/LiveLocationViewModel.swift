//
//  LiveLocationModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine

class LiveLocationViewModel: ObservableObject {
    
    @Published var tripData: TripHistory?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(tripHistory: TripHistory? = nil) {
        self.tripData = tripHistory
    }
    
    func driverArrivedRequest(_ tripId: String) async  {  //
        isLoading = true
        defer {
            isLoading = false
        }
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.driverArrived(token: token, tripId: tripId)
            if  response.isSuccess{
                print(response)
                tripData = response.data?.toTripHistory()
             }
             else {
                 print(response.message ?? "")
                 errorMessage = response.message
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func changeTripRequest(_ tripId: String) async  {
        isLoading = true
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.changeStatus(token: token, tripId: tripId , status: TripStatus.arrivedB.rawValue)
            if  response.isSuccess{
                print(response)
                errorMessage = response.message
             }
             else {
                 print(response.message ?? "")
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func cancelTrip(_ tripId: String) async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
        do {
            guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
          let response  =   try await rep.cancelTrip(token: token, tripId: tripId)
            if  response.isSuccess{
                print(response)
                 errorMessage = response.message
             }
             else {
                 print(response.message ?? "")
                 errorMessage = response.message
             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func startGotoBTrip(_ tripId: String) async {
       
        isLoading = true
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
        do {
            guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
            let response  =   try await rep.startTrip(token: token, tripId: tripId)
            errorMessage = response.message
            if  response.isSuccess{
                print(response)
                if let tripData = response.data {
                    self.tripData = tripData
                }
             }
             else {
                 print(response.message ?? "")
             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
    }
    
    func endTripArrivedB(_ tripId: String)  async {
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
        do {
            guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
            let response  =   try await rep.endTrip(token: token, tripId: tripId, distance: "0")
            errorMessage = response.message
            if  response.isSuccess{
                print(response)
                
             }
             else {
                 print(response.message ?? "")
             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
}
