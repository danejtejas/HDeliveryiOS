//
//  LiveLocationModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//


import SwiftUI
import Combine



@MainActor
class LiveLocationViewModel: ObservableObject {
    
    @Published var tripData: TripHistory?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isCancelled: Bool = false
    
    @Published var isShowToast: Bool = false
    
    @Published var isTripEnd: Bool = false
    
    @Published var isGotDistance: Bool = false
    
    @Published var totalDistance: String = ""
     
    
    init(tripHistory: TripHistory? = nil) {
        self.tripData = tripHistory
    }
    
    func driverArrivedRequest(_ tripId: String) async  {  //
        isLoading = true
        isShowToast = false
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
                 isShowToast = true
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    func changeTripRequest(_ tripId: String) async  {
        isLoading = true
        isCancelled = true
        isShowToast = false
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
         do {
             guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
             
             let response = try await rep.changeStatus(token: token, tripId: tripId , status: TripStatus.arrivedB.rawValue)
            
            if  response.isSuccess{
                print(response)
                isCancelled = true
                errorMessage = response.message
                isShowToast = false
             }
             else {
                 print(response.message ?? "")
                 errorMessage = response.message
                 isShowToast = true
             }
             
        } catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
            isShowToast = true

        }
    }
    
    func cancelTrip(_ tripId: String) async {
        isShowToast = false
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
                 isShowToast = true

             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
            isShowToast = true
        }
    }
    
    func startGotoBTrip(_ tripId: String) async {
        isShowToast = false
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
                 errorMessage =  response.message
                 isShowToast = true

             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
            isShowToast = true

        }
        
    }
    
    
    func getDistance(_ tripId: String) async  {
        isShowToast = false
        isLoading = true
        defer {
            isLoading = false
        }
        
        let rep = AppDependencies.shared.makeTripRepository()
        do {
            guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
            let response  =   try await rep.showDistance(token: token, tripId: tripId)
            errorMessage = response.message
            if  response.isSuccess{
                print(response)
//                isTripEnd = true
                if let data = response.data {
                    totalDistance = "\(data)"
                    isGotDistance = true
                }
                
             }
             else {
                 print(response.message ?? "")
                  errorMessage =  response.message
                 isShowToast = true
             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
            isShowToast = true

        }
    }
    
    
    func endTripArrivedB(_ tripId: String)  async {
        isShowToast = false
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
                isTripEnd = true
                if let data = response.data {
                    tripData = data
                }
                
             }
             else {
                 print(response.message ?? "")
                  errorMessage =  response.message
                 isShowToast = true
             }
        }
        catch {
            print("eror message = > " ,error.localizedDescription)
            errorMessage = error.localizedDescription
            isShowToast = true

        }
    }
    
}
