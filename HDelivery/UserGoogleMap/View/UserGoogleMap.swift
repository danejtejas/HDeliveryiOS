//
//  UserGoogleMap.swift
//  HDelivery
//
//  Created by Tejas on 10/10/25.
//


import SwiftUI
import GoogleMaps
import CoreLocation
import ToastSwiftUI


struct UserGoogleMap: View {
    @StateObject private var locationManager = GMSLocationManager()
    
    //    @Binding var tripData : TripData?
    @Binding var tripData : TripHistory?
    
    @State var showToast: Bool = false
    @State var showToastMessage: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var liveLocationViewModel =  LiveLocationViewModel()
    
    @State var isShowRatingPopup: Bool = false
    
    
    
    
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
                        presentationMode.wrappedValue.dismiss()
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
                    
                    Text("Distance: \(tripData?.distance ?? "")")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                    
                    HStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(tripData?.driver?.name ?? "")
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
                            
                            // Rating stars
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                Text(tripData?.driver?.rate ?? "0")
                            }
                            
                        }
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text(getStatus())
                                .foregroundColor(.white)
                                .frame(width: 150, height: 30)
                                .background(Color.green)
                                .cornerRadius(12)
                                .font(.system(size: 12))
                            
                            AsyncImage(url: URL(string: tripData?.driver?.profileImage ?? ""))
                                .frame(width: 50, height: 50)
                            
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
        .fullScreenCover(isPresented: $isShowRatingPopup) {
            UserRateView(tripData: $tripData)
        }
        .toast(isPresenting: $showToast, message: showToastMessage)
        
        .onReceive(NotificationCenter.default.publisher(for: .driverArrived)) { notification in
            print("Driver arrived 🚗")
            guard let data =  notification.object as? TripHistory else {return}
            withAnimation {
                self.tripData = data
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .tripStarted)) { notification in
            print("Driver tripStarted 🚗")
            DispatchQueue.main.async{
                guard let data =  notification.object as? TripHistory else {return}
                
                self.tripData = data
            }
            
        }.onReceive(NotificationCenter.default.publisher(for: .tripEnded)) { notificaton in
            print("Trip ended 🏁")
            
            DispatchQueue.main.async {
                guard let data =  notificaton.object as? TripHistory else {return}
                
                self.tripData = data
                
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .paymentPending)) { notificaton in
            print("Payment pending 💳")
            
            DispatchQueue.main.async {
                guard let data =  notificaton.object as? TripHistory else {return}
                
                self.tripData = data
                self.isShowRatingPopup = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .cancelTrip)) { notificaton in
            print("Trip Calleded ended ")
            DispatchQueue.main.async {
                self.showToast = true
                self.showToastMessage = "Trip has been calleded by the driver"
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
    }
    
    private func callNumber() {
        if let url = URL(string: "tel://\(tripData?.driver?.phone ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendSMS() {
        if let url = URL(string: "sms:\(tripData?.driver?.phone ?? "")") {
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
    
    private func getStatus() -> String {
        let status =  TripStatus(rawValue: tripData?.status ?? "")
        switch status {
            
        case .approaching: return "Tasker Arriving A"
            
        case .inProgress: return "Tasker Arriving B"
            
        case .arrivedA:
            return "Tasker Arriving B"
        case .arrivedB: return "Fineded"
            
        case .startTask:
            return "Start Trip To B"
            
        default : break;
            
        }
        
        return ""
    }
}
