//
//  GoogleMapView.swift
//  HDelivery
//
//  Created by Tejas on 01/10/25.
//

import SwiftUI
import GoogleMaps
import GoogleMapsUtils
import CoreLocation
import UIKit

struct GoogleMapView: UIViewRepresentable {
    var pickupCoordinate: CLLocationCoordinate2D? = nil
    var dropCoordinate: CLLocationCoordinate2D? = nil
    let pickupTitle: String = "A"
    let dropTitle: String = "B"

    @Binding var region: GMSCameraPosition?
    
    
  
    
    func makeUIView(context: Context) -> GMSMapView {
        
        let latCor =   37.7749 //  LocationManager.shared.currentLocation?.coordinate.latitude ??
        let long  =  -122.4194 //LocationManager.shared.currentLocation?.coordinate.longitude ??
        
        let camera = GMSCameraPosition.camera(
            withLatitude: latCor,   // Example: San Francisco
            longitude: long,
            zoom: 12.0
        )
        //
        
        if let cameraRegion = region {
            print("GoogleMapView initial camera region set: \(cameraRegion)")
            let mapView = GMSMapView.map(withFrame: .zero, camera: cameraRegion)
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            return mapView
        }
        else {
            let mapView = GMSMapView.map(withFrame: .zero, camera: camera )
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            return mapView
        }
        
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        print("GoogleMapView updateUIView called")
       
        
        uiView.clear()

        uiView.camera = region ??  uiView.camera
        
        var bounds: GMSCoordinateBounds? = nil

        if let pickupCoordinate {
            print("Adding pickup marker at: \(pickupCoordinate)")
            let marker = GMSMarker(position: pickupCoordinate)
            marker.title = pickupTitle
            marker.icon = UIImage(named: "my_marker_A")
            marker.map = uiView
            bounds = GMSCoordinateBounds(coordinate: pickupCoordinate, coordinate: pickupCoordinate)
        } else  {
            print("Pickup coordinate: nil ")
        }

        if let dropCoordinate {
            print("Adding drop marker at: \(dropCoordinate)")
            let marker = GMSMarker(position: dropCoordinate)
            marker.title = dropTitle
            marker.icon = UIImage(named: "my_marker_B")
            marker.map = uiView
            if let existing = bounds {
                bounds = existing.includingCoordinate(dropCoordinate)
            } else {
                bounds = GMSCoordinateBounds(coordinate: dropCoordinate, coordinate: dropCoordinate)
            }
        }
        else {
            print("Drop coordinate: nil")

        }

        if let bounds {
            print("Fitting camera to bounds with both coordinates")
            print("Bounds: \(bounds)")
            
            // Calculate center point between both locations
            if let pickup = pickupCoordinate, let drop = dropCoordinate {
                let centerLat = (pickup.latitude + drop.latitude) / 2
                let centerLng = (pickup.longitude + drop.longitude) / 2
                let centerCoordinate = CLLocationCoordinate2D(latitude: centerLat, longitude: centerLng)
                
                print("Center coordinate calculated: \(centerCoordinate)")
                
                // Calculate appropriate zoom level based on distance
                let distance = distanceBetweenCoordinates(pickup, drop)
                let zoom = calculateZoomLevel(for: distance)
                
                print("Distance between locations: \(distance) meters, zoom level: \(zoom)")
                
                // Set camera to center with calculated zoom
                let camera = GMSCameraPosition.camera(withTarget: centerCoordinate, zoom: zoom)
                uiView.animate(to: camera)
            } else {
                // Fallback to bounds fitting if center calculation fails
                let update = GMSCameraUpdate.fit(bounds, withPadding: 80)
                uiView.moveCamera(update)
            }
        } else if let pickupCoordinate {
            print("Animating camera to pickup coordinate")
            let camera = GMSCameraPosition.camera(withTarget: pickupCoordinate, zoom: 14)
            uiView.animate(to: camera)
        } else if let dropCoordinate {
            print("Animating camera to drop coordinate")
            let camera = GMSCameraPosition.camera(withTarget: dropCoordinate, zoom: 14)
            uiView.animate(to: camera)
        } else {
            print("No coordinates available for camera update")
        }
    }
    
    // Helper function to calculate distance between two coordinates
    private func distanceBetweenCoordinates(_ coord1: CLLocationCoordinate2D, _ coord2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distance(from: location2)
    }
    
    // Helper function to calculate appropriate zoom level based on distance
    private func calculateZoomLevel(for distance: Double) -> Float {
        switch distance {
        case 0..<1000:        // Less than 1km
            return 15.0
        case 1000..<5000:     // 1-5km
            return 13.0
        case 5000..<10000:    // 5-10km
            return 12.0
        case 10000..<25000:   // 10-25km
            return 11.0
        case 25000..<50000:   // 25-50km
            return 10.0
        case 50000..<100000:  // 50-100km
            return 9.0
        default:              // More than 100km
            return 8.0
        }
    }
}



