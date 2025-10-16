//
//  TripViewModel.swift
//  
//
//  Created by Tejas on 03/10/25.
//



import Foundation
import Combine
import CoreLocation

final class TripViewModel: ObservableObject {
    @Published var trips: [TripDetail] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let repository: TripRepository
    
    @Published var isSuccess = false
    @Published var itemDescription : String?
    
    var selectedItem : [Item] = []
    
    init(repository: TripRepository = AppDependencies.shared.makeTripRepository()) {
        self.repository = repository
    }
    

    
    func createTripRequest(pickupCoordinate :CLLocationCoordinate2D?, dropCoordinate : CLLocationCoordinate2D?, pickupAddress : String?, dropAddress : String?, receiverPhone : String? ) async  {
        isLoading = true
        errorMessage = nil
       
        do {
            let token = try  StorageManager.shared.getAuthToken() ?? ""
            
            let startLat = pickupCoordinate?.lat() ?? ""
            let startLong = pickupCoordinate?.lon() ?? ""
            
            let endLat = dropCoordinate?.lat() ?? ""
            let endLong = dropCoordinate?.lon() ?? ""
            
            let startLocation = pickupAddress ?? ""
            let endLocation = dropAddress ?? ""
            
            var selectItemForPickup = selectedItem.toSelectIem()
            
            let jsonEndodeData = try! JSONEncoder().encode(selectItemForPickup)
            let jsonString = String(data: jsonEndodeData, encoding: .utf8) ?? ""
            
            let request = CreateTripRequest(
                token: token,
                link: "2",
                startLat:  startLat,
                startLong: startLong,
                startLocation: startLocation,
                endLat: endLat,
                endLong: endLong,
                endLocation: endLocation,
                estimateDistance: "5.2",
                itemId: jsonString,
                receiver_phone : receiverPhone ?? ""
            )
            
            let response = try await repository.createTrip(request)
            print(response.data)
            if !response.isSuccess {
                
                errorMessage = response.message
            }
            else {
                
                
                
                isSuccess = true
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}




extension CLLocationCoordinate2D {
    func lat() -> String {
        return String(self.latitude)
    }
    
    func lon() -> String {
        return String(self.longitude)
    }
}

extension Item {
    func toSelectItem() -> SelectItem {
        .init(item_id: id, itme_qty: "\(quantity)", item_desc: description)
    }
}

struct SelectItem : Codable {
    let item_id: String
    let itme_qty: String
    let item_desc: String
}


extension Array where Element == Item {
    func toSelectIem() -> [SelectItem] {
        self.map { $0.toSelectItem() }
    }
}
