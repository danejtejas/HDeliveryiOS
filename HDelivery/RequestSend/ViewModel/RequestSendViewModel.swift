//
//  RequestSendViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//


import SwiftUI

@MainActor
final class RequestSendViewModel: ObservableObject {

    private let repository: TripRepository
    @Published var isSuccess = false //  use for cancel trip
    @Published var isLoading = false
    @Published var errorMessage: String?

    var selectedItem: [Item] = []
    
    @Published var tripDetails : [TripDetailResponse] = []
    @Published var driverCount : Int = 0
    
    
    var timer: Timer?

    
    
    
    init(repository: TripRepository = AppDependencies.shared.makeTripRepository()) {
        self.repository = repository
        startTimer()
    }

   
    
    func cancelTripRequest() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let token = try  StorageManager.shared.getAuthToken()  ?? ""
            let request = try await repository.cancelRequest(token: token, driver: "0")
            self.isSuccess = request.isSuccess
            if !isSuccess {
                errorMessage = request.message
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.isSuccess = false
        }
        
        isLoading = false
       
    }
    
    
    
    // not set isLoginding 
    func showMyRequest() async {
       
        errorMessage = nil
        
        do {
            
            let token = try  StorageManager.shared.getAuthToken()  ?? ""
            let request = try await repository.showMyRequests(token: token, driver: "0")
            if self.isSuccess {
                if let trip =  request.data {
                    self.tripDetails = trip
                    self.driverCount = trip.map{$0.driver?.isOnline}.count
                }
            }
            else  {
                errorMessage = request.message
            }
        }
        catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func startTimer()  {
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            Task{
                await  self.showMyRequest()
            }
         
        }
    }
    
}
