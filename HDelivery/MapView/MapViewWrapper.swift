//
//  MapViewWrapper.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI
import MapKit

struct MapViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        // Customize here
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Update map when SwiftUI state changes
    }
}
