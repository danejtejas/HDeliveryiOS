//
//  DriverRateView.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//

import SwiftUI
import ToastSwiftUI


enum paymentModeType: Int {
    case none  = 0
    case wallet = 1
    case cash  = 2
    case stripe = 3
    
}

struct UserRateView: View {
    @State private var rating: Int = 0
    @State private var isLoading: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @StateObject private var userRateViewModel = UserRateViewModel()
    
    @StateObject private var userPaymentViewModel  = UserPaymentViewModel()
    
    @State private var showPaymentSheet = false

  
    @Binding var tripData: TripHistory?
    @State var tripId: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isPaymentTabped : Bool = false
    @State var isRatingDone : Bool = false
    
    
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
//            ConfirmPaymentView(tripId: tripData?.id ?? "")
            SignatureScreen(tripData: tripData)
        })
        
        // MARK: - Bottom Sheet
        .confirmationDialog(
            "Choose Payment Method",
            isPresented: $showPaymentSheet,
            titleVisibility: .visible
        ) {
            Button("Wallet 💳") {
                paymentProcess(type: .wallet)
            }
            
            Button("Cash 💵") {
                paymentProcess(type: .cash)
            }
            
            Button("Cancel", role: .cancel) {
                isPaymentTabped = false
            }
        } message: {
            Text("Select your preferred payment option for this trip.")
        }
        
        
        
        .toast(isPresenting: $showAlert, message: alertMessage)
        .toast(isPresenting: $userRateViewModel.isShowAlert, message: userRateViewModel.message ?? "")
        .toast(isPresenting: $userPaymentViewModel.isShowAlert, message: userPaymentViewModel.message ?? "")
        .overlay {
            if userRateViewModel.isLoading || userPaymentViewModel.isLoading {
                LoadView()
            }
        }
        
    }
}

// MARK: - Subviews
extension UserRateView {
    
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
            
            if !isRatingDone {
                self.alertMessage = "Please share your rating first"
                self.showAlert = true
                return
            }
            
            showPaymentSheet.toggle()
            
//            guard let tripId = tripData?.id else { return }
//            self.tripId = tripId
//            Task{
//                guard let tripId = tripData?.id else { return  }
//                await userPaymentViewModel.paymentRequest(tripId: tripId)
//            }
        } label: {
            Text("Payment")
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
extension UserRateView {
    private func submitRating() async {
        
        if rating == 0 {
            self.alertMessage = "Please select a rating"
            self.showAlert = true
            return
        }
       
        guard let tripId = tripData?.id else { return }
        await userRateViewModel.rateDriver(tripId: tripId, rating: "\(rating)")
        isRatingDone = true
    }
}


extension UserRateView {
    func paymentProcess(type : paymentModeType)  {
        
        guard let tripId = tripData?.id else { return }
        self.tripId = tripId
        Task{
            guard let tripId = tripData?.id else { return  }
            await userPaymentViewModel.paymentRequest(tripId: tripId, paymentMethod: type)
        }
        
    }
}

