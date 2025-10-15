//
//  ConfirmPaymentView.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI

import SwiftUI

struct ConfirmPaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoading = false
    
    @StateObject private var paymentVM = DriverPaymentViewModel()
    
//    @Binding var tripData: TripHistory?
     var tripId : String?
    
    var body: some View {
        ZStack {
            // Background color
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // MARK: - Title
                Text("CONFIRM?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                // MARK: - Question Text
                Text("Did you receive payment of the trip yet?")
                    .font(.system(size: 18, weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // MARK: - Buttons
                HStack(spacing: 20) {
                    // ❌ No Button
                    Button(action: {
                        handleNoAction()
                    }) {
                        Text("No, I didn’t")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    
                    // ✅ Yes Button
                    Button(action: {
                        handleYesAction()
                    }) {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(8)
                        } else {
                            Text("Yes, I did")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Actions
    private func handleNoAction() {
        // Example: navigate back or show alert
        presentationMode.wrappedValue.dismiss()
    }
    
    private func handleYesAction() {
        Task {
            isLoading = true
            guard let tripId = tripId else {
                isLoading = false
                return
            }
            await paymentVM.confirmDriverPayment(tripId: tripId)
            isLoading = false
            presentationMode.wrappedValue.dismiss()
        }
    }
}

//#Preview {
//    ConfirmPaymentView(tripId: .constant("385"))
//}

