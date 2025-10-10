//
//  UserGoogleMap.swift
//  HDelivery
//
//  Created by Tejas on 10/10/25.
//


import SwiftUI
import GoogleMaps
import CoreLocation

struct UserGoogleMap: View {
    @StateObject private var locationManager = GMSLocationManager()
    
    //    @Binding var tripData : TripData?
  var tripData : TripHistory?
    
    @StateObject private var liveLocationViewModel =  LiveLocationViewModel()
    
    
    var body: some View {
        ZStack(alignment: .top) {
            GoogleMapLiveView(userLocation: $locationManager.userLocation,
                              pickupLocation: CLLocationCoordinate2D(latitude: tripData?.startLat!.toCLLocationDegrees() ??  0, longitude: tripData?.startLong?.toCLLocationDegrees() ?? 0 ),
                              destination:  CLLocationCoordinate2D(latitude: tripData?.endLat!.toCLLocationDegrees() ??  0, longitude: tripData?.endLong?.toCLLocationDegrees() ?? 0 ))
                .edgesIgnoringSafeArea(.all)
            
            // Top bar
            HStack {
                Button(action: {
                    Task{
                      await  liveLocationViewModel.cancelTrip(tripData?.id ?? "")
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
                    Text("To: \(tripData?.endLocation ?? "")")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(tripData?.passenger?.fullName ?? "")
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
        .navigationTitle("User Google Map")
        .onAppear {
            locationManager.start()
        }
        
    }
    
    private func callNumber() {
        if let url = URL(string: "tel://\(tripData?.passenger?.phone ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendSMS() {
        if let url = URL(string: "sms:\(tripData?.passenger?.phone ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    private func arrivedAction() {
        print("Arrived tapped")
        Task{
            
            let status =  TripStatus(rawValue: tripData?.status ?? "")
            switch status {
                
            case .arrivedA:
                await liveLocationViewModel.startGotoBTrip(tripData?.id ?? "") //
            case .inProgress:
                await liveLocationViewModel.endTripArrivedB(tripData?.id ?? "") // G
            case .startTask:
                await liveLocationViewModel.startGotoBTrip(tripData?.id ?? "") // Go To start
                
            default :
                break
            }
        }
    }
    
    private func getButtonTitle() -> String {
        let status =  TripStatus(rawValue: tripData?.status ?? "")
        switch status {
        
        case .inProgress: return "Arrived B"
            
        case .arrivedA:
            return "Go To B"
        case .arrivedB: return "Fineded"
            
        case .startTask:
            return "Arrived B"
            
        default :
            return "Arrived B"
        }
        
        
    }
}
