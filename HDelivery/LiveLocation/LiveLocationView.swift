//
//  LiveLocationView.swift
//  HDelivery
//
//  Created by Tejas on 07/10/25.
//



import SwiftUI
import GoogleMaps
import CoreLocation



struct GoogleMapNavigationView: View {
    @StateObject private var locationManager = GMSLocationManager()
    
    //    @Binding var tripData : TripData?
//    @Binding var tripData : TripHistory?
    
   
    @ObservedObject var viewModel: LiveLocationViewModel   // 👈 changed

    init(liveLocationViewModel: LiveLocationViewModel) {
       
        self.viewModel = liveLocationViewModel
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            GoogleMapLiveView(userLocation: $locationManager.userLocation,
                              pickupLocation: CLLocationCoordinate2D(latitude: viewModel.tripData?.startLat!.toCLLocationDegrees() ??  0, longitude: viewModel.tripData?.startLong?.toCLLocationDegrees() ?? 0 ),
                              destination:  CLLocationCoordinate2D(latitude: viewModel.tripData?.endLat!.toCLLocationDegrees() ??  0, longitude: viewModel.tripData?.endLong?.toCLLocationDegrees() ?? 0 ))
                .edgesIgnoringSafeArea(.all)
            
            // Top bar
            HStack {
                Button(action: {
                    Task{
                        await  viewModel.cancelTrip(viewModel.tripData?.id ?? "")
                    }
                    
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("CANCEL").bold()
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(8)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            // Bottom panel
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    Text("To: \(viewModel.tripData?.endLocation ?? "")")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(viewModel.tripData?.passenger?.fullName ?? "")
                                .font(.headline)
                            HStack {
                                Button(action: callNumber) {
                                    Image(systemName: "phone.fill")
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                                Button(action: sendSMS) {
                                    Image(systemName: "message.fill")
                                        .padding(8)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                            }
                        }
                        Spacer()
                        Button(action: arrivedAction) {
                            Text(  getButtonTitle() )
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 90, height: 90)
                            .background(Color.green)
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 3)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            locationManager.start()
        }
        .overlay {
            
        }
    }
    
    private func callNumber() {
        if let url = URL(string: "tel://\(viewModel.tripData?.passenger?.phone ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendSMS() {
        if let url = URL(string: "sms:\(viewModel.tripData?.passenger?.phone ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    private func arrivedAction() {
        print("Arrived tapped")
        Task{
            
            let status =  TripStatus(rawValue: viewModel.tripData?.status ?? "")
            switch status {
            case .approaching:
                await viewModel.driverArrivedRequest(viewModel.tripData?.id ?? "")
            case .arrivedA:
                await viewModel.startGotoBTrip(viewModel.tripData?.id ?? "") //
            case .inProgress:
                await viewModel.endTripArrivedB(viewModel.tripData?.id ?? "") // G
            case .startTask:
                await viewModel.startGotoBTrip(viewModel.tripData?.id ?? "") // Go To start
                
            default :
                break
            }
        }
    }
    
    private func getButtonTitle() -> String {
        let status =  TripStatus(rawValue: viewModel.tripData?.status ?? "")
        switch status {
       
        case .approaching: return "Arrived A"
            
        case .inProgress: return "Arrived B"
            
        case .arrivedA:
            return "Go To B"
        case .arrivedB: return "Fineded"
            
        case .startTask:
            return "Arrived B"
            
        default :
            break
        }
        
        return ""
        
    }
}

//#Preview {
//    GoogleMapNavigationView(tripData: .constant(PrivewData.shared.tripData))
//}

struct GoogleMapLiveView: UIViewRepresentable {
    @Binding var userLocation: CLLocation?
    let pickupLocation: CLLocationCoordinate2D?
    let destination: CLLocationCoordinate2D?
    
    private let mapView = GMSMapView()
    
    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        // Destination marker
        if let pickupLocation = pickupLocation {
            let marker = GMSMarker(position: pickupLocation)
            marker.title = "Pickup"
            marker.icon =  UIImage(named: "my_marker_A")
            marker.map = mapView
        }
        if let destination = destination  {
            let marker = GMSMarker(position: destination)
            marker.title = "Destination"
            marker.icon =  UIImage(named: "my_marker_A")
            marker.map = mapView
        }
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        if let location = userLocation {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: 13)
            uiView.animate(to: camera)
            
            // Draw route between source and destination
            //            drawRoute(from: location.coordinate, to: destination, on: uiView)
            if let destination = self.destination {
                drawRoute(from: location.coordinate, to: destination, on: uiView)
            }
        }
    }
    
    private func drawRoute(from source: CLLocationCoordinate2D, to dest: CLLocationCoordinate2D, on mapView: GMSMapView) {
        let urlString = "https://routes.googleapis.com/directions/v2:computeRoutes"
        guard let url = URL(string: urlString) else { return }
        
        let body: [String: Any] = [
            "origin": ["location": ["latLng": ["latitude": source.latitude, "longitude": source.longitude]]],
            "destination": ["location": ["latLng": ["latitude": dest.latitude, "longitude": dest.longitude]]],
            "travelMode": "DRIVE",
            "routingPreference": "TRAFFIC_AWARE"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(AppSetting.GoogleKeySetting.mapKey)", forHTTPHeaderField: "X-Goog-Api-Key")
        request.addValue("application/json", forHTTPHeaderField: "X-Goog-FieldMask")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("Route fetch error:", error?.localizedDescription ?? "unknown")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let routes = json["routes"] as? [[String: Any]],
                   let first = routes.first,
                   let polylineData = first["polyline"] as? [String: Any],
                   let encodedPolyline = polylineData["encodedPolyline"] as? String {
                    DispatchQueue.main.async {
                        let path = GMSPath(fromEncodedPath: encodedPolyline)
                        let polyline = GMSPolyline(path: path)
                        polyline.strokeWidth = 6
                        polyline.strokeColor = .systemBlue
                        polyline.map = mapView
                    }
                } else {
                    print("Unexpected JSON:")
                }
            } catch {
                print("Decode error:", error.localizedDescription)
            }
        }.resume()
    }
    
}

// MARK: - Location Manager
final class GMSLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = loc
            Task {
                await self.updateCoordinate(lat: loc.coordinate.latitude.description, long: loc.coordinate.longitude.description)
            }
        }
    }
    
    
    func updateCoordinate(lat: String, long: String) async {
        //        isLoading = true
        //        defer { isLoading = false }
        do {
            let repo =   AppDependencies.shared.makeDriverRepository()
            guard let token = try StorageManager.shared.getAuthToken() else { print("No Token Found");  return  }
            let response = try await repo.updateCoordinate(token: token, lat: lat, long: long)
            //            message = response.message
            //            isSuccess = response.isSuccess
        } catch {
        print("\(error.localizedDescription)")
           
        }
    }
    
}


extension String {
    func toCLLocationDegrees() -> CLLocationDegrees {
        return Double(self) ?? 0
    }
}
