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
        case .approaching: return "Approaching (Driver confirmed and approaching)"
        case .inProgress: return "In Progress (Trip started)"
        case .pendingPayment: return "Pending Payment (Trip ended, waiting for payment)"
        case .finished: return "Finished (Trip completed)"
        case .arrivedA: return "Arrived at Pickup (A)"
        case .arrivedB: return "Arrived at Destination (B)"
        case .startTask: return "Start Task (Task started)"
        case .unknown: return "Unknown Status"
        }
    }
}




class ContentViewModel: ObservableObject {
    
    @Published var isNavToGoogleNavigaation : Bool = false
    @Published var isNavToPayment : Bool = false
    @Published  var tripHistory : TripHistory?
    
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
                    //                  await showMyTripHistoryDriver()
                    await checkDriverInTrip()
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
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    
    // for driver
    //    func showMyTripHistoryDriver() async {   // check driver online
    //        let repository =  AppDependencies.shared.makeTripRepository()
    //        do {
    //            let token = try StorageManager.shared.getAuthToken() ?? ""
    //
    //            let request = try await repository.showMyUserRequests(token: token, driver: )
    //            if request.isSuccess {
    //                let tripData = request.data ?? []
    //                if tripData.count > 0 {
    //                    let tripStaus = tripData[0].status
    //                    let  passengerRate =  tripData[0].passengerRate ?? "0"
    //
    //                    if tripData[0].isWattingConfirm == "1" {
    //                        // Move to Request Screen
    //                        tripData.first?.driver
    //                    }
    //                }
    //            }
    //        } catch {
    //            print("error \(error.localizedDescription)")
    //        }
    //    }
    
    
   
    

    
    
    
    
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




// Drive Method
extension ContentViewModel {
    
        
    func checkOnlineDriver( ) async {
        //        isLoading = true
        //        errorMessage = nil
        let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTripHistory(token: token, page: "1")
            if response.isSuccess, let data = response.data {
                print(data)
                handleDriverStatus(tripData: data[0])
            } else {
                //                errorMessage = response.message
            }
        } catch {
            //            errorMessage = error.localizedDescription
        }
        //        isLoading = false
    }
    
    
    
    func  countMyRequest() {
        
    }
    
    
    func handleDriverStatus(tripData :  TripHistory) {
        
        let driver = tripData.driver
        
        
        let status = tripData.status
        let passengerRate = tripData.passengerRate
        let isWaitDriverConfirm =  tripData.isWattingConfirm
        
        if isWaitDriverConfirm == "1" {
            //            navigateToConfirmPayByCash(tripId: tripId)  // navigate to payment screen
        }
        else {
            if driver.status ==  "1" {
                //                countMyRequest()
            } else {
                switch status {
                case "3", "4":
                    
                    if let rate = passengerRate, !rate.isEmpty {
                        countMyRequest()
                    }
                    else {
                        // navigateToRatingPassenger()
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
            if response.isSuccess, let data = response.data {
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
                case .pendingPayment: break
                    
                case .finished:  break
                    
                case .arrivedA:
                    // GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .arrivedB:
                    //  GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .startTask:
//                    GoogleMapNavigationView()
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



// User
extension ContentViewModel {
    
    func checkUserInTrip() async {
        
        let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTripHistory(token: token, page: "1")
            if response.isSuccess, let data = response.data {
                print(data)
                let trip = data[0]
                let status = trip.status
                let tripRate = trip.passengerRate
                tripHistory = trip
                let tripStatus =  TripStatus(rawValue: status ?? "") ?? .unknown
                switch tripStatus {
                
                case .approaching:
//                    GoogleMapNavigationView() // navigate to start screen
                    isNavToGoogleNavigaation = true
                    
                case .inProgress:
//                      GoogleMapNavigationView() // navigate to start screen
                    isNavToGoogleNavigaation = true
                case .pendingPayment: 
                    isNavToPayment = true
                case .finished:  break
                    
                case .arrivedA:
                    // GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .arrivedB:
                    //  GoogleMapNavigationView()
                    isNavToGoogleNavigaation = true
                case .startTask:
//                    GoogleMapNavigationView()
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
