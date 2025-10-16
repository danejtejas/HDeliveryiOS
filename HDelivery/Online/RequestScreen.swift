//
//  RequestScreen.swift
//  HDelivery
//
//  Created by user286520 on 9/30/25.
// user for this scren Driver request and set online link offline

import SwiftUI



struct RequestScreen: View {
    
    var onSelectTab : () -> Void
    @StateObject private var onllineViewModel = OnlineViewModel()
     
    @State private var isNavToUserGoogleMap: Bool = false
    @State private var tripHistory : TripHistory?
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.28, green: 0.42, blue: 0.71),
                    Color(red: 0.20, green: 0.31, blue: 0.58)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top menu button
                HStack {
                    Button(action: {
                        onSelectTab()
                        
                    }) {
                        VStack(spacing: 4) {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 30, height: 3)
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 30, height: 3)
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 30, height: 3)
                        }
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Main content
                VStack(spacing: 30) {
                    // Title with circles
                    HStack(spacing: 8) {
                        Text("REQUEST")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(.white)
                        
                        ForEach(0..<5) { _ in
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                    // Instruction text
                    Text("Tap the ONLINE button below to start\nreceiving Requests")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                    
                    // Online button
                    Button(action: {
                        Task {
                            await onllineViewModel.setOnlineDrivers()
                        }
                        
                    }) {
                        Text( onllineViewModel.isOnline ? "OFF LINE" : "ONLINE")
                            .font(.system(size: 24, weight: .medium))
                            .italic()
                            .foregroundColor(.white)
                            .frame(width: 220, height: 80)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill( onllineViewModel.isOnline ? Color.green.opacity(0.3) : Color.clear)
                                    )
                            )
                    }
                    .padding(.top, 20)
                    
                    // GPS warning text
                    Text("Make sure device's GPS is good and have a\nclear sky view")
                        .font(.system(size: 16))
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.top, 10)
                }
                Spacer()
                if onllineViewModel.isOnline && onllineViewModel.trips.count > 0 {
                    
                   
                    TripRowRequestView(trips: $onllineViewModel.trips) { index in
                        Task {
                            let trip = onllineViewModel.trips[index]
                            await onllineViewModel.confrimDriverRequest(requestId: trip.id ?? "" , startLat: trip.startLat ?? "", startLong: trip.startLong ?? "", startLocation: trip.startLocation ?? "")
                        }
                    }
                    
                    
                    
                }
                
            }
        }
        .fullScreenCover(isPresented:$onllineViewModel.isRequestConformed) {
            GoogleMapNavigationView(liveLocationViewModel: LiveLocationViewModel(tripHistory: onllineViewModel.tripHistory))
        }
    }
}


#Preview {
    RequestScreen(onSelectTab:{})
}



struct TripRowRequestView : View {
    
    @Binding var trips : [TripDetailResponse]
    
    var onSelectTrip : (Int) -> Void
    
    
    var body: some View {
        
        
            
            
            ForEach(Array(trips.enumerated()), id: \.offset) { index, trip in
                VStack(alignment: .leading, spacing: 6) {
                    Text("Passenger: \(trip.passenger?.fullName ?? "Unknown")")
                    Text("Driver: \(trip.driver?.fullName ?? "Unknown")")
                    Text("From: \(trip.startLocation ?? "-")")
                    Text("To: \(trip.endLocation ?? "-")")
                    Text("Fare: \(trip.estimateFare ?? "-")")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .onTapGesture {
                    
                    onSelectTrip(index)
                    
                    
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 1)
            }
            
            
            
        
        
    }
}
