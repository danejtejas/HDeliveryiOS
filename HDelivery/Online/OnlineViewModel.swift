//
//  OnlineViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI

class OnlineViewModel: ObservableObject {
    
    private let repository:  DriverRepository
    @Published var isOnline: Bool = false
    @Published var error: String?
    @Published var isLoading: Bool = false
    @Published var trips = [TripDetailResponse] ()
    @Published var isRequestConformed: Bool = false
    var tripData : TripData?
    
    init(repository: DriverRepository = AppDependencies.shared.makeDriverRepository()){
        self.repository = repository
         
    }
    
    func setOnlineDrivers() async   {
        isLoading  = true
        error = nil
        let status = isOnline ? "0" : "1"
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let requset = try await repository.setOnlineStatus(token: token, status: status)
            if  requset.isSuccess {
                isOnline.toggle()
                Task {
                    if isOnline {
                        await self.showMyRequest()
                    }
                   
                }
            }
            else {
                error = requset.message
            }
            
        }catch {
//            error = error.localizedDescription
            print("Error ==> \(error.localizedDescription)")
        }
        
    }
    
    var getPassengerName : String {
        return  trips.first?.passenger?.fullName ?? ""
    }
    
    // not set isLoginding
    func showMyRequest() async {
       
        isLoading = true
        
        do {
            let rep = AppDependencies.shared.makeTripRepository()
            let token = try  StorageManager.shared.getAuthToken()  ?? ""
            let request = try await rep.showMyDriverRequests(token: token)
            
            if request.isSuccess {
                if let trips =  request.data {
                    self.trips = trips
                }
            }
            else  {
                error = request.message
                print("error = \(String(describing: error))")
            }
        }
        catch {
            self.error = error.localizedDescription
            print("error = \(String(describing: error))")
        }
    }
    
    func confrimDriverRequest(requestId : String, startLat: String, startLong: String, startLocation: String) async {
        
        let rep = AppDependencies.shared.makeTripRepository()
        do {
            let token = try  StorageManager.shared.getAuthToken()  ?? ""
            let repsone = try await rep.confirmTrip(DriverConfirmRequest(token: token, requestId: requestId, startLat: startLat, startLong: startLong, startLocation: startLocation))
            if  repsone.isSuccess, let data  = repsone.data {
                print(data   )
                self.isRequestConformed = true
                self.tripData =  data
            }
            else {
                print(repsone.message ?? "")
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}
