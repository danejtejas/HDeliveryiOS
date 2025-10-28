//
//  NotificationManager.swift
//  HDelivery
//
//  Created by Tejas on 15/10/25.
//


import Foundation
import UIKit


enum NotificationActionType: String {
    case driverConfirm
    case driverArrived
    case startTrip
    case endTrip
    case passengerPaymentPending
    case cancelTrip
}



extension Notification.Name {
    static let createRequest = Notification.Name("createRequest")
    static let driverConfirmedTrip = Notification.Name("driverConfirmedTrip")
    static let driverArrived = Notification.Name("driverArrived")
    static let tripStarted = Notification.Name("tripStarted")
    static let tripEnded = Notification.Name("tripEnded")
    static let paymentPending = Notification.Name("paymentPending")
    static let cancelTrip = Notification.Name("cancelTrip")
}






class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
    private override init() {}
    
    // MARK: - Main Receiver
    func receiveNotification(userInfo: [AnyHashable: Any]) async {
        guard let actionString = userInfo["action"] as? String,
              let actionType = NotificationActionType(rawValue: actionString) else {
            print("⚠️ Unknown or missing notification action")
            return
        }
        
        print("🔗 Handle notification type: \(actionType.rawValue)")
        
        if let action = userInfo["action"] as? String {
            print("🔗 Action type: \(action)") // "driverConfirm"
        }

        if let tripId = userInfo["tripId"] as? Int {
            print("🚗 Trip ID: \(tripId)") // 389
        }

        if let tripStatus = userInfo["trip_status"] as? Int {
            print("📦 Trip Status: \(tripStatus)") // 1
        }

        if let body = userInfo["body"] as? String {
            print("📝 Body: \(body)")
        }

        if let tripIdString = userInfo["tripId"] as? String ?? (userInfo["tripId"] as? NSNumber)?.stringValue {
            print("🚗 Trip ID: \(tripIdString)")
        } else {
            print("⚠️ tripId missing or invalid")
        }

        if let tripStatusString = userInfo["trip_status"] as? String ?? (userInfo["trip_status"] as? NSNumber)?.stringValue {
            print("📦 Trip Status: \(tripStatusString)")
        }

        if let action = userInfo["action"] as? String {
            print("🎬 Action: \(action)")
        }

        if let body = userInfo["body"] as? String {
            print("📝 Body: \(body)")
        }

        
        
        
        // Route to specific handler
         handleNotification(for: actionType, data: userInfo)
    }
    
    // MARK: - Router
     private func handleNotification(for type: NotificationActionType, data: [AnyHashable: Any])  {
        switch type {
        case .driverConfirm:
             handleDriverConfirm(data)
        case .driverArrived:
            handleDriverArrived(data)
        case .startTrip:
            handleStartTrip(data)
        case .endTrip:
            handleEndTrip(data)
        case .passengerPaymentPending:
            handlePassengerPaymentPending(data)
            
        case .cancelTrip:
            handleCancelTripBuyDriver(data)
        }
    }
}


extension NotificationManager {
    func handleDriverConfirm(_ data: [AnyHashable: Any]) {
        print("✅ Driver confirmed trip.")
        
        
        
        guard let tripIdString = data["tripId"] as? String ?? (data["tripId"] as? NSNumber)?.stringValue else {
            print("🚗 Trip ID: nont")
            return
        }
        print("🚗 Trip ID: \(tripIdString)")
        
          let  tripId = tripIdString
        
//        guard let tripId = data["tripId"] as? Int else {
//            print("⚠️ Missing tripId in notification data")
//            return
//        }
        
        Task {
            // Fetch trip details asynchronously
            do {
                let tripHistoryData = try await getTripData(tripId: "\(tripId)")
                
                // ✅ Always post notifications on main thread
                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .driverConfirmedTrip,
                        object: tripHistoryData
                    )
                    print("📩 Notification posted on main thread")
                }
                
            }
            catch {
                print("⚠️ Error fetching trip data: \(error)")
            }
            
        }
    }
}




extension NotificationManager {
    func handleDriverArrived(_ data: [AnyHashable: Any]) {
        print("📍 Driver has arrived at the pickup location.")
        // Example:
        guard let tripId = data["tripId"] as? Int else {
            print("⚠️ Missing tripId in notification data")
            return
        }
        
        Task {
            // Fetch trip details asynchronously
            do {
                let tripHistoryData = try await getTripData(tripId: "\(tripId)")
                
                // ✅ Always post notifications on main thread
                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .driverArrived,
                        object: tripHistoryData
                    )
                    print("📩 Notification posted on main thread")
                }
                
            }
            catch {
                print("⚠️ Error fetching trip data: \(error)")
            }
            
        }
        
        
      
    }
}


extension NotificationManager {
    func handleStartTrip(_ data: [AnyHashable: Any]) {
        print("🚕 Trip started.")
        // Example:
         
        guard let tripId = data["tripId"] as? Int else {
            print("⚠️ Missing tripId in notification data")
            return
        }
        
        Task {
            // Fetch trip details asynchronously
            do {
                let tripHistoryData = try await getTripData(tripId: "\(tripId)")
                
                // ✅ Always post notifications on main thread
                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .tripStarted,
                        object: tripHistoryData
                    )
                    print("📩 Notification posted on main thread")
                }
                
            }
            catch {
                print("⚠️ Error fetching trip data: \(error)")
            }
            
        }
        
    }
}


extension NotificationManager {
    func handleEndTrip(_ data: [AnyHashable: Any]) {
        print("🏁 Trip ended.")
        // Example:
        
        
        guard let tripId = data["tripId"] as? Int else {
            print("⚠️ Missing tripId in notification data")
            return
        }
        
        Task{
            // Fetch trip details asynchronously
            do {
                let tripHistoryData = try await getTripData(tripId: "\(tripId)")
                
                // ✅ Always post notifications on main thread
                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .tripEnded,
                        object: tripHistoryData
                    )
                    print("📩 Notification posted on main thread")
                }
                
            }
            catch {
                print("⚠️ Error fetching trip data: \(error)")
            }
            
        }
        
        
       
    }
}


extension NotificationManager {
    func handlePassengerPaymentPending(_ data: [AnyHashable: Any]) {
        print("💳 Passenger payment pending.")
        // Example:
        
        

        guard let tripId = data["tripId"] as? Int else {
            print("⚠️ Missing tripId in notification data")
            return
        }
        
        Task{
            // Fetch trip details asynchronously
            do {
                let tripHistoryData = try await getTripData(tripId: "\(tripId)")
                
                // ✅ Always post notifications on main thread
                await MainActor.run {
                    NotificationCenter.default.post(
                        name: .paymentPending,
                        object: tripHistoryData
                    )
                    print("📩 Notification posted on main thread")
                }
                
            }
            catch {
                print("⚠️ Error fetching trip data: \(error)")
            }
            
        }
        
    }
}


extension NotificationManager {
    func handleCancelTripBuyDriver(_ data: [AnyHashable: Any])  {
        print("💳 cancelTrip by driver ")
        NotificationCenter.default.post(
            name: .cancelTrip,
            object: nil)
        
    }
}




extension NotificationManager {
    private func getTripData( tripId : String) async throws -> TripHistory? {
        do {
            let repso = AppDependencies.shared.makeTripRepository()
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await  repso.showTripDetail(token: token, tripId: tripId)
            if response.isSuccess {
                return  response.data
            }
        }
        catch {
            throw error
        }
        return nil
    }
}
