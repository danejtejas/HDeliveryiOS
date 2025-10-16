//
//  RequestSendView.swift
//  HDelivery
//
//  Created by Tejas on 04/10/25.
//

import SwiftUI

struct RequestSendView: View {
    @State private var isTaskCancelled = false
    @StateObject private var viewModel = RequestSendViewModel()
    @Environment(\.dismiss) private var dismiss
    @State var tripData : TripHistory?
    @State var isNavToUserGoogleMap : Bool = false
    
    var body: some View {
        VStack {
            // Top Navigation
            HStack {
                Button(action: {
                    // Action for back
                    
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }
            
            Spacer()
            
            // Title + Request Indicator
            VStack(spacing: 12) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 10, height: 10)
                    
                    Text("REQUEST")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    ForEach(0..<4) { _ in
                        Circle()
                            .stroke(Color.yellow, lineWidth: 2)
                            .frame(width: 10, height: 10)
                    }
                }
                
                Text("Following requests has been sent")
                    .font(.body)
                    .foregroundColor(.white)
                
                Text("awaiting for tasker confirmation")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Cancel Button
            Button(action: {
                
                Task{
                    await viewModel.cancelTripRequest()
                }
                
                
            }) {
                Text("CANCEL TASK")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 40)
            
            // Fare Info
            Text("Estimated fare: ₦12550 ~ 210.24KM")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 20)
            
            Spacer()
            
            // Footer
            Text("\(viewModel.driverCount) tasker has received your request. Your request will auto refresh every 10 seconds")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
        }
        .fullScreenCover(isPresented: $isNavToUserGoogleMap) {
            UserGoogleMap(tripData: tripData)
        }
        .background(Color.blue.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    ProgressView("")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .transition(.opacity)
            }
        }
        .onChange(of: viewModel.isSuccess) { newValue in
            if newValue == true {
                dismiss()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .driverConfirmedTrip)) { notification in
            print("Driver confirmed ✅")
            
            guard let data =  notification.object as? TripHistory else {return}
            
            tripData = data
            withAnimation {
                isNavToUserGoogleMap = true
            }
        }

        
    }
}

#Preview {
    RequestSendView()
}


