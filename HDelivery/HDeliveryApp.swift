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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
//        let mananer = LocationManager.shared
        GMSServices.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
        GMSPlacesClient.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
        try? StorageManager.shared.storeAuthToken("c08ae527ff9c471d9ebd95dad8e4f564") // driver
        try? StorageManager.shared.setUserId(userId: "204")
    }
    
    
    var body: some Scene {
        WindowGroup {
//            DeliveryLoginView()
//            GoogleMapNavigationView()
            if StorageManager.shared.isUserLoggedIn() || true {
                ContentView()
            }else {
                DeliveryLoginView()
            }
        }
    }
    
}



