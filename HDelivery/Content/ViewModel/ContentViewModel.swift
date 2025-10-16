//
//  ContentViewModel.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI


enum TripStatus: String, Codable {
    case approaching = "1"      // Driver confirmed and approaching
    case inProgress = "2"       // Trip started
    case pendingPayment = "3"   // Trip ended, waiting for payment
    case finished = "4"         // Trip completed
    case arrivedA = "6"         // Driver arrived at pickup
    case arrivedB = "7"         // Driver arrived at destination
    case startTask = "8"        // Task started
    case unknown                // fallback for unrecognized status

    var description: String {
        switch self {
        case .approaching: return "Approaching (Driver confirmed and approaching)"  // Driver Confirmed
        case .inProgress: return "In Progress (Trip started)"     // 
        case .pendingPayment: return "Pending Payment (Trip ended, waiting for payment)"
        case .finished: return "Finished (Trip completed)"
        case .arrivedA: return "Arrived at Pickup (A)"
        case .arrivedB: return "Arrived at Destination (B)"
        case .startTask: return "Start Task (Task started)"
        case .unknown: return "Unknown Status"
        }
    }
}





@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var isNavToGoogleNavigaation : Bool = false
    @Published var isNavToPayment : Bool = false
    @Published var isNavToPaymentDriver : Bool = false
    @Published  var tripHistory : TripHistory?
    @Published  var isNavToUserGoogleMap : Bool = false
    @Published var  isNavToDriverRate : Bool = false
    
    @Published var  isNavUserRequest : Bool = false
    
    
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
                let appConfig = request.data
                try StorageManager.shared.setAppConfig(appConfig: appConfig)
                let link_type = request.listJob.first?.link ?? ""
                StorageManager.shared.setLinkType(link: link_type)
                
                Task {
                    await showUserInfo()
                    //await showMyTripHistoryDriver()
//                    await checkDriverInTrip()
//                      await checkOnlineDriver( )
                    
//                    await  checkUserInTrip()
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
            if request.isSuccess, let userInfo = request.data {
                try StorageManager.shared.setUserInfo(userInfo)
                
                if let user = StorageManager.shared.getUserInfo(), let userIsActive = user.isActive, userIsActive == "1" {
                    
                    if let driverIsActive = user.driver?.isActive{
                        if driverIsActive == "1" {
                            try StorageManager.shared.setIsDriver(true)
                            try StorageManager.shared.setIsDriverActive(true)
                        }
                        else {
                            try StorageManager.shared.setIsDriver(false)
                            try StorageManager.shared.setIsDriverActive(false)
                        }
                    }
                    else {
                        try StorageManager.shared.setIsUser(true)
                    }
                }
                
                if try StorageManager.shared.getIsDriver() {
                    await checkOnlineDriver()
                }
                else {
                    await showMyUserRequest()
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}




//MARK: DRIVER METHODS
extension ContentViewModel {
    
        
    func checkOnlineDriver( ) async {
        //        isLoading = true
        //        errorMessage = nil
        
        if StorageManager.shared.getUserInfo()?.driver?.status == "1" {
            
            let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
            do {
                let token = try StorageManager.shared.getAuthToken() ?? ""
                let response = try await repository.getTripHistory(token: token, page: "1")
                if response.isSuccess, let data = response.data, data.count > 0 {
                    print(data)
                    tripHistory = data[0]
                    handleDriverStatus(tripData: data[0])
                
                } else {
                    //                errorMessage = response.message
                }
            } catch {
                //            errorMessage = error.localizedDescription
            }
            
            
        }
        else if  StorageManager.shared.getUserInfo()?.driver?.status == "0" {
            await  checkDriverInTrip();
        }
        else {
           await   showMyUserRequest()
        }
        
       
    }
    
    
    
    func  countMyRequest() {
        
    }
    
    
    func handleDriverStatus(tripData :  TripHistory) {
        
        let driver = tripData.driver

        let status = tripData.status
        let passengerRate = tripData.passengerRate
        let isWaitDriverConfirm =  tripData.isWattingConfirm
        
        if isWaitDriverConfirm == "1" {
            isNavToPaymentDriver = true
        }
        else {
            if driver?.status ==  "1" {
                                countMyRequest()
            } else {
                switch status {
                case "3", "4":
                    
                    if let rate = passengerRate, !rate.isEmpty {
                        countMyRequest()
                    }
                    else {
                        isNavToDriverRate = true
                    }
                    
                default:
                    countMyRequest()
                }
            }
        }
    }
    
    
    func checkDriverInTrip() async {
        
        let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTripHistory(token: token, page: "1")
            if response.isSuccess, let data = response.data , data.count > 0 {
                print(data)
                let trip = data[0]
                let status = trip.status
                let tripRate = trip.passengerRate
                tripHistory = trip
                let tripStatus =  TripStatus(rawValue: status ?? "") ?? .unknown
                switch tripStatus {
                    
                case .approaching:
                    isNavToGoogleNavigaation = true
                    
                case .inProgress:
                    //                      GoogleMapNavigationView() // navigate to start screen
                    isNavToGoogleNavigaation = true
                case .pendingPayment:
                    isNavToPaymentDriver = true
                case .finished:  break
                    
                case .arrivedA:
                    // GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .arrivedB:
                    //  GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .startTask:
                    //
                    isNavToGoogleNavigaation = true
                case .unknown:
                    print("unknown")
                }
                
                
            } else {
                //                errorMessage = response.message
            }
        } catch {
            //            errorMessage = error.localizedDescription
        }
        
        
    }
    
}



//MARK: USER METHODS
extension ContentViewModel {
    
    func showMyUserRequest() async {
        let repository =  AppDependencies.shared.makeTripRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let request = try await repository.showMyUserRequests(token: token, driver: "0" )
            if request.isSuccess {
                let tripData = request.data ?? []
                if tripData.count > 0 {
                    let tripStaus = tripData[0].status
                    let requestId = tripData[0].id
                    isNavUserRequest = true
                }
                else {
                    await checkUserInTrip()
                }
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    
    
    func checkUserInTrip() async {
        
        let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTripHistory(token: token, page: "1")
            if response.isSuccess, let data = response.data, data.count > 0 {
                print(data)
                let trip = data[0]
                let status = trip.status
                let tripRate = trip.passengerRate
                tripHistory = trip
                let tripStatus =  TripStatus(rawValue: status ?? "") ?? .unknown
                switch tripStatus {
                
                case .approaching:
//                    GoogleMapNavigationView() // navigate to start screen
                    isNavToUserGoogleMap = true
                    
                case .inProgress:
//                      GoogleMapNavigationView() // navigate to start screen
                    isNavToUserGoogleMap = true
                case .pendingPayment:
                    isNavToPayment = true
                case .finished:break
                    
                case .arrivedA:
                    // GoogleMapNavigationView()
                    isNavToUserGoogleMap = true
                case .arrivedB:
                    //  GoogleMapNavigationView()
                    isNavToUserGoogleMap = true
                case .startTask:
//                    GoogleMapNavigationView()
                    isNavToUserGoogleMap = true
                case .unknown:
                    print("unknown")
                }
                
              
            } else {
                //                errorMessage = response.message
            }
        } catch {
            //            errorMessage = error.localizedDescription
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
                    let tripStaus = tripData[0].status
                

                }
                
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
