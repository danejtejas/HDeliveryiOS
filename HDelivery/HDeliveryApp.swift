//
//  HDeliveryApp.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct HDeliveryApp: App {
    
    init() {
        GMSServices.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
        GMSPlacesClient.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
    }
    
//    var body: some Scene {
//        WindowGroup {
//           ContentView()
//        }
//    }
    
//    var body: some Scene {
//        WindowGroup {
//           OnboardingPageView()
//        }
//    }
    
    var body: some Scene {
        WindowGroup {
          DeliveryLoginView()
        }
    }
    
//    var body: some Scene {
//        
//        WindowGroup {
//            NavigationView {
//                LocationMapView(
//                    viewModel: LocationViewModel(
//                        locationProvider: LocationManager(),
//                        mapService: MapServiceFactory.createMapService(for: .apple)
//                    )
//                )
//                .navigationTitle("Location Map")
//                .navigationBarTitleDisplayMode(.inline)
//            }
//        }
//    }
    
}



