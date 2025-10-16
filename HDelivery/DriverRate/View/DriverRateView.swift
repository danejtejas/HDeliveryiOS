//
//  DriverRateView.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//

import SwiftUI


import SwiftUI

struct DriverRateView: View {
    @State private var rating: Int = 0
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @StateObject private var driverRateViewModel = DriverRateViewModel()
    
    @Binding var tripData: TripHistory?
    @State var tripId: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isPaymentTabped : Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                passengerInfoSection
                tripInfoSection
                tripSummarySection
                payButton
            }
            .padding()
        }
        .background(Color.blue.ignoresSafeArea())
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $isPaymentTabped, content: {
            ConfirmPaymentView(tripId: tripData?.id ?? "")
        })
        .alert("Message", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
}

// MARK: - Subviews
extension DriverRateView {
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("● ● ● ● ○  FINISHED ○")
                .font(.title3.bold())
                .foregroundColor(.yellow)
            Text("Your task has finished")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(.top, 30)
    }
    
    private var passengerInfoSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(tripData?.passenger?.fullName ?? "")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(tripData?.passenger?.phone ?? "")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                Spacer()
                starRow
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var starRow: some View {
        HStack(spacing: 4) {
            ForEach(0..<5, id: \.self) { index in
                let passengerRating = Int(tripData?.passengerRate ?? "0")
                Image(systemName: index < (passengerRating ?? 0) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }

    
    private var tripInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Type: ").foregroundColor(.white)
            Text("From A: \(tripData?.startLocation ?? "")").foregroundColor(.white)
            Text("To B: \(tripData?.endLocation ?? "")").foregroundColor(.white)
            Text("Car Plate: \(tripData?.driver?.carPlate ?? "")").foregroundColor(.white)
            Text("Identity: \(tripData?.endLocation ?? "")").foregroundColor(.white)
            
            ratingSection
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var ratingSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rate").foregroundColor(.white)
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .onTapGesture { rating = index }
                }
            }
            
            Button {
                Task { await submitRating() }
            } label: {
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
    
    private var tripSummarySection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Trip:").foregroundColor(.white)
                Spacer()
                Text(tripData?.distanceFormat ?? "0") .foregroundColor(.white)
              
            }
            HStack {
                Text("Task:").foregroundColor(.white)
                Spacer()
                Text("0 minute").foregroundColor(.white)
            }
            HStack {
                Text("Fare:").foregroundColor(.white)
                Spacer()
                Text(tripData?.estimateFare ?? "0").foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.black.opacity(0.2))
        .cornerRadius(10)
    }
    
    private var payButton: some View {
        Button {
            guard let tripId = tripData?.id else { return }
            self.tripId = tripId
            self.isPaymentTabped = true
        } label: {
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
}

// MARK: - Logic
extension DriverRateView {
    private func submitRating() async {
        guard let tripId = tripData?.id else { return }
        await driverRateViewModel.ratePassenger(tripId: tripId, rate: "\(rating)")
    }
}
