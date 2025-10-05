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
        let mananer = LocationManager.shared
        GMSServices.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
        GMSPlacesClient.provideAPIKey(AppSetting.GoogleKeySetting.mapKey)
//        try? StorageManager.shared.storeAuthToken("95a47771a27336ed1d1f5e86fd2ad6ed")
    }
    
    
    var body: some Scene {
        WindowGroup {
            if StorageManager.shared.isUserLoggedIn() {
                ContentView()
            }else {
                DeliveryLoginView()
            }
        }
    }
    
}



