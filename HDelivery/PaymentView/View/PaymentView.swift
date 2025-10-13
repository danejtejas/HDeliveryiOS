//
//  PaymentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI


struct PaymentView: View {
   
    
    var onSildeMenuTap: () -> Void
    @StateObject private var viewModel: PaymentViewModel = .init()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
            
                
                VStack {
                    // Top section with profile
                    VStack(spacing: 0) {
                       
                        // Profile section
                        VStack(spacing: 20) {
                            // Profile image
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 140, height: 140)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.gray)
                                )
                                .clipShape(Circle())
                            
                            // Name
                            Text(viewModel.fullName ?? "")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                            
                            // Rating stars
                            HStack(spacing: 12) {
                                ForEach(0..<5) { index in
                                    Circle()
                                        .fill(Color.white.opacity(0.7))
                                        .frame(width: 35, height: 35)
                                        .overlay(
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.blue)
                                        )
                                }
                            }
                        }
                        .padding(.top, 90) // Spacing from the top
                    }
                    .background(AppSetting.ColorSetting.appBg)
                    .frame(maxHeight: 500) // Fixed height for top section
                   
                    
                    
                    // Scrollable content: Balance and Wallet Action Buttons
                    ScrollView {
                        VStack(spacing: 0) {
                            // Balance Section
                            VStack {
                                Text(viewModel.balance ?? "0")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.vertical, 25)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                            }
                            
                            // Action Buttons Section
                            VStack(spacing: 12) {
                                NavigationLink(destination: DepositView()){ Text("Deposite")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                NavigationLink(destination: PayoutView()){ Text("PAYOUT")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                NavigationLink(destination: DepositView()){ Text("TRANSFER")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                                NavigationLink(destination: TransactionHistoriesView()){ Text("HISTORIES")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }

                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 25)
                            .padding(.bottom, 40)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Payment", displayMode: .inline)  // Set the navigation title
        .toolbar {
            // Menu button (left side of the navigation bar)
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        onSildeMenuTap()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            // Set navigation bar title color to white
            ToolbarItem(placement: .principal) {
                Text("Payment")
                    .font(.title3)
                    .foregroundColor(.white)  // Title color set to white
            }
        }
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        .background(
            Color.blue
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
        ) // Optional: For visual consistency (header background)
        .ignoresSafeArea()
    }
}


#Preview {
    NavigationStack {
        PaymentView(onSildeMenuTap: {})
    }
}
