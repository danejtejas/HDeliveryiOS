//
//  GoogleMapView.swift
//  HDelivery
//
//  Created by Tejas on 01/10/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(
            withLatitude: 37.7749,   // Example: San Francisco
            longitude: -122.4194,
            zoom: 12.0
        )
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update camera, markers, etc. if needed
    }
}
