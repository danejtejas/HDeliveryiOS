//
//  APIDriverRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

import SwiftUI
import CoreLocation

@MainActor
class DriverSearchViewModel: ObservableObject {
    @Published var drivers: [DriverInfo] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let driverRepo: DriverRepository
    
    init(driverRepo: DriverRepository = AppDependencies.shared.makeDriverRepository()) {
        self.driverRepo = driverRepo
        
        
         
        let latCor =  LocationManager.shared.currentLocation?.coordinate.lat() ?? ""
        let long  =  LocationManager.shared.currentLocation?.coordinate.lon() ?? ""
        
        Task {
            await searchDrivers(
                lat: latCor,
                long: long,
                carType: "2",
                distance: "6.2516703605651855"
            )
        }

    }
    
    func searchDrivers(lat: String, long: String, carType: String, distance: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        let latStr = lat
        let longStr = long
        let carTypeStr = carType
        let distanceStr = distance
        do {
            let response = try await driverRepo.searchDrivers(
                startLat: latStr,
                startLong: longStr,
                carType: carTypeStr,
                distance: distanceStr
            )
            
            if response.isSuccess, let data = response.data {
                self.drivers = data
            } else {
                self.errorMessage = response.message
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
