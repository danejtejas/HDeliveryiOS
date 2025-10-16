//
//  HomeViewModel.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import SwiftUI
import CoreLocation
import Combine
import MapKit
import GoogleMaps

class HomeViewModel: ObservableObject {
    @Published var locationStatus: String = "Unknown"
    @Published var coordinateText: String = "No location"
    @Published var shouldUpdateRegion = false
    
    @Published var cameraPosition: GMSCameraPosition?
    
    private let locationProvider: LocationProviding
    private var cancellables = Set<AnyCancellable>()
    
    init(locationProvider: LocationManager = LocationManager()) {
        
        self.locationProvider = locationProvider
        
        let latCor =   37.7749 //  LocationManager.shared.currentLocation?.coordinate.latitude ??
        let long  =  -122.4194 //LocationManager.shared.currentLocation?.coordinate.longitude ??
        
        let cameraPosition = GMSCameraPosition.camera(
            withLatitude: latCor,   // Example: San Francisco
            longitude: long,
            zoom: 12.0
        )
//
        
        self.observeLocation() // ✅ Now safe to use
    }
    
    private func observeLocation() {
        guard let locationManager = locationProvider as? LocationManager else { return }
        
        locationManager.$currentLocation
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.updateLocation(location)
            }
            .store(in: &cancellables)
        
        locationManager.$authorizationStatus
            .sink { [weak self] status in
                self?.updateStatusText(status)
            }
            .store(in: &cancellables)
    }
    
    private func updateLocation(_ location: CLLocation) {
        coordinateText = "Lat: \(String(format: "%.4f", location.coordinate.latitude)), Lon: \(String(format: "%.4f", location.coordinate.longitude))"
        
        // Optionally update camera
        cameraPosition = GMSCameraPosition.camera(
            withLatitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: 15.0
        )
    }
    
    private func updateStatusText(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: locationStatus = "Not Determined"
        case .restricted: locationStatus = "Restricted"
        case .denied: locationStatus = "Denied"
        case .authorizedAlways: locationStatus = "Authorized Always"
        case .authorizedWhenInUse: locationStatus = "Authorized When In Use"
        @unknown default: locationStatus = "Unknown"
        }
    }
    
    var currentCoordinate: CLLocationCoordinate2D? {
        locationProvider.currentLocation?.coordinate
    }
    
    func requestPermission() {
        locationProvider.requestPermission()
    }
    
    func startTracking() {
        locationProvider.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationProvider.stopUpdatingLocation()
    }
    
    func centerOnUser() {
        guard let location = locationProvider.currentLocation else { return }
        
        shouldUpdateRegion = true
    }
}
