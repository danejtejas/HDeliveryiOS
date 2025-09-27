//
//  PaymentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI
//
//struct PaymentView: View {
//    var body: some View {
//        ZStack
//        {
//            Color.blue
//                .ignoresSafeArea(edges: .top)
//            
//            VStack(spacing: 12) {
//                Spacer().frame(height: 20)
//                
//                // Profile Image
//                Image(systemName: "pepeal") //
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
//                
//                // Name
//                Text("Rutvik Demo 2")
//                    .font(.title3)
//                    .foregroundColor(.white)
//                
//                // Rating stars
//                HStack(spacing: 6) {
//                    ForEach(0..<5) { _ in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.white)
//                    }
//                }
//                
//                Spacer().frame(height: 20)
//            }
//            .frame(maxWidth: .infinity)
//            
//            //                 Hamburger menu
//            Button(action: {}) {
//                Image(systemName: "line.3.horizontal")
//                    .foregroundColor(.white)
//                    .font(.title2)
//                    .padding()
//            }
//        }
//        .frame(height: 220)
//        
//        VStack(alignment: .center, spacing: 20) {
//            
//            Text("$1999.99")
//            Button("DEPOSIT") {
//                
//            }.background(Color.blue)
//                .foregroundColor(Color.white)
//            
//            Button("DEPOSIT") {
//                
//            }.background(Color.blue)
//                .foregroundColor(Color.white)
//                .frame(height: 50)
//            Button("DEPOSIT") {
//                
//            }.background(Color.blue)
//                .foregroundColor(Color.white)
//            Button("DEPOSIT") {
//                
//            }.background(Color.blue)
//                .foregroundColor(Color.white)
//            
//        }.frame(width: 200)
//        
//    }
//}
//
//#Preview {
//    PaymentView()
//}






struct PaymentView: View {
    @State private var balance: String = "₦199.99"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                VStack(spacing: 0) {
                    // Top blue section
                    Color.blue
                        .frame(height: geometry.size.height * 0.65)
                    
                    // Bottom light gray section
                    Color(.systemGray6)
                        .frame(height: geometry.size.height * 0.35)
                }
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top section with profile
                    VStack(spacing: 0) {
                        // Navigation bar
                        HStack {
                            Button(action: {
                                // Menu action
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        
                        Spacer()
                        
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
                            Text("Rutvik Demo 2")
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
                        
                        Spacer()
                    }
                    .frame(height: 500)
                    
                    // Bottom section with wallet and buttons
                    VStack(spacing: 0) {
                        // Balance section
                        VStack {
                            Text(balance)
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .background(Color.white)
                        
                        // Action buttons section
                         ScrollView {
                            VStack(spacing: 12) {
                                WalletActionButton(title: "DEPOSIT") {
                                    // Deposit action
                                    print("Deposit tapped")
                                }
                                
                                WalletActionButton(title: "PAYOUT") {
                                    // Payout action
                                    print("Payout tapped")
                                }
                                
                                WalletActionButton(title: "TRANSFER") {
                                    // Transfer action
                                    print("Transfer tapped")
                                }
                                
                                WalletActionButton(title: "HISTORIES") {
                                    // Histories action
                                    print("Histories tapped")
                                }
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 25)
                            .padding(.bottom, 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct WalletActionButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

#Preview {
    PaymentView()
}
