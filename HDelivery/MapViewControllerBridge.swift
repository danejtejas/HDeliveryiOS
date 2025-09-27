//
//  MapViewControllerBridge.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//


//import GoogleMaps
//import SwiftUI
//
//struct MapView: UIViewRepresentable {
//  
//    let marker : GMSMarker = GMSMarker()
//
//       /// Creates a `UIView` instance to be presented.
//       func makeUIView(context: Self.Context) -> GMSMapView {
//           // Create a GMSCameraPosition that tells the map to display the
//           // coordinate -33.86,151.20 at zoom level 6.
//           let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//           let mapView = GMSMapView.init(options: GMSMapViewOptions())
//
//           return mapView
//       }
//
//       /// Updates the presented `UIView` (and coordinator) to the latest
//       /// configuration.
//       func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
//           // Creates a marker in the center of the map.
//           marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//           marker.title = "Sydney"
//           marker.snippet = "Australia"
//           marker.map = mapView
//       }
//    
//    
//    
//   
//}
