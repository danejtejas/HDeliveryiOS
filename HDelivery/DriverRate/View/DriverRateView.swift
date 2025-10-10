//
//  DriverRateView.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//

import SwiftUI


struct DriverRateView: View {
    @State private var rating: Int = 0
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    

    @StateObject private var driverRateViewModel =  DriverRateViewModel()
    @StateObject private var driverPaymentViewModel  = DriverPaymentViewModel()
    
    var tripData : TripHistory?
    
    @Environment(\.presentationMode) var isPresentationMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("● ● ● ● ○  FINISHED ○")
                        .font(.title3.bold())
                        .foregroundColor(.yellow)
                    Text("Your task has finished")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 30)
                
                // User Info
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Rutvik demo 1")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("1111xxx xxx")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            ForEach(0..<5) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                
                // Trip Info
                VStack(alignment: .leading, spacing: 10) {
                    Text("Type: ").foregroundColor(.white)
                    Text("From A:" ).foregroundColor(.white)
                    Text("To B:  ").foregroundColor(.white)
                    Text("Car Plate: ").foregroundColor(.white)
                    Text("Identity: ").foregroundColor(.white)
                    
                    // Rating Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rate").foregroundColor(.white)
                        HStack {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                        
                        Button(action: {
                            Task {
                                await submitRating()
                            }
                        }) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)
                            } else {
                                Text("RATE")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                
                // Trip Summary
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Trip:").foregroundColor(.white)
                        Spacer()
                        Text("0.0 KM (1 minutes)").foregroundColor(.white)
                    }
                    HStack {
                        Text("Task:").foregroundColor(.white)
                        Spacer()
                        Text("0 minute").foregroundColor(.white)
                    }
                    HStack {
                        Text("Fare:").foregroundColor(.white)
                        Spacer()
                        Text("₦2100.00").foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                
                // Pay Button
                Button(action: {
                    
                    Task{
                        guard let tripId = tripData?.id else { return  }
                        await driverPaymentViewModel.confirmDriverPayment(tripId: tripId)
                    }
                    
                }) {
                    Text("PAY NOW")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .background(Color.blue.ignoresSafeArea())
        .navigationBarHidden(true)
        .alert("Message", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    // MARK: - Submit Rating Function
    private func submitRating() async {
        guard let tripId = tripData?.id else { return  }
        await driverRateViewModel.ratePassenger(tripId: tripId)
    }
}


