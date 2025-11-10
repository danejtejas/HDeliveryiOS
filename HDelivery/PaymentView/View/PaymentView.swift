//
//  PaymentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

struct PaymentView: View {
    @StateObject private var viewModel: PaymentViewModel = .init()
    var onSildeMenuTap: () -> Void
    var body: some View {
        VStack(spacing: 0,) {
            
            ZStack(alignment: .top) {
                AppSetting.ColorSetting.appBg.ignoresSafeArea(.all)
            
                
                VStack(alignment: .center, spacing: 10 ) {
                    
                    AsyncImage(url: viewModel.prfileImageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                                .padding(.top, 20)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .padding(.top, 20)
                        case .failure:
                            Image(systemName: "user")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        @unknown default:
                            Circle()
                                .fill(Color.black)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                )
                        
                            .padding(.top, 20)
                        }
                    }
                    
                    
                    // Username
                    Text(viewModel.fullName ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    // Rating stars
                    HStack(spacing: 5) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(viewModel.rateing) ?? 0 ? "star.fill" : "star")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.top, 0)
                .frame(height: 100)
            }
            .frame(height: 300, alignment: .top)
            
            // MARK: - Balance
            Text("₦ \(viewModel.balance ?? "0.00")")
                .font(.custom("Georgia-BoldItalic", size: 22))
                .padding(.vertical, 20)
                .foregroundColor(.black)
            
            // MARK: - Buttons (2x2 grid using VStack + HStack)
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    NavigationButton(title: "DEPOSIT", destination: DepositView())
                    NavigationButton(title: "PAYOUT", destination: PayoutView())
                }
                HStack(spacing: 20) {
                    NavigationButton(title: "TRANSFER", destination: DepositView())
                    NavigationButton(title: "HISTORIES", destination: TransactionHistoriesView())
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 10)
            
        }
        .padding(.top, 0)
        .padding(.bottom, 30)
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
    }
}





// MARK: - Reusable Navigation Button View
struct NavigationButton<Destination: View>: View {
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(systemName: iconFor(title: title))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
        }
    }
    
    // Pick icons based on title
    func iconFor(title: String) -> String {
        switch title.uppercased() {
        case "DEPOSIT": return "banknote"
        case "PAYOUT": return "creditcard"
        case "TRANSFER": return "arrow.left.arrow.right"
        case "HISTORIES": return "clock.arrow.circlepath"
        default: return "circle"
        }
    }
}



#Preview {
    NavigationStack {
        PaymentView(onSildeMenuTap: {})
        
    }
}
