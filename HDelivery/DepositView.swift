//
//  DepositView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI


struct DepositView: View {
    @State private var depositAmount: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    private let currentBalance: Double = 199.99
    
    var body: some View {
        ZStack {
            // Background gradient
           
            Color.blue.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Custom Navigation Bar
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                    }
                    
                    Spacer()
                    
                    Text("Deposit")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .medium))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
                    .frame(height: 40)
                
                // Balance Section
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        
                        Text("Your Balance")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium))
                          
                    }
                    
                    Text("₦\(String(format: "%.2f", currentBalance))")
                        .foregroundColor(.white)
                        .font(.system(size: 48, weight: .light))
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 50)
                
                // Amount Input Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                        Text("Amount")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                           
                    }
                    
                    TextField("0", text: $depositAmount)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                                .background(Color.clear)
                        )
                        .keyboardType(.decimalPad)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 30)
                
                // Pay Button
                Button(action: {
                    handleDeposit()
                }) {
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                        
                        Spacer()
                        
                        Text("Pay")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange)
                    )
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    private func handleDeposit() {
        guard let amount = Double(depositAmount), amount > 0 else {
            // Show alert for invalid amount
            return
        }
        
        // Process deposit logic here
        print("Processing deposit of ₦\(amount)")
        
        // Clear the input field
        depositAmount = ""
        
        // You can add success feedback here
    }
}


#Preview {
    DepositView()
}
