//
//  HDeliveryApp.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

@main
struct HDeliveryApp: App {
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
    
//    var body: some Scene {
//        WindowGroup {
//          DeliveryLoginView()
//        }
//    }
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                LocationMapView(
                    viewModel: LocationViewModel(
                        locationProvider: LocationManager(),
                        mapService: MapServiceFactory.createMapService(for: .apple)
                    )
                )
                .navigationTitle("Location Map")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
}
