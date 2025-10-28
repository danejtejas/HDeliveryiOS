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
        VStack(spacing: 0) {
            
            ZStack {
                AppSetting.ColorSetting.appBg.ignoresSafeArea()
                
                
                
                VStack(alignment: .center, spacing: 15 ) {
                    
                    // Profile image
                    Circle()
                        .fill(Color.black)
                        .frame(width: 120, height: 120)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    
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
                .padding(.top, 50)
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
        .background(
            Color.blue
                .edgesIgnoringSafeArea(.top)
                .frame(height: 0)
        ) // Optional: For visual consistency (header background)
        .ignoresSafeArea()
        //        .background(Color.white.ignoresSafeArea())
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





//struct PaymentView: View {
//
//
//    var onSildeMenuTap: () -> Void
//    @StateObject private var viewModel: PaymentViewModel = .init()
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//
//
//                VStack {
//                    // Top section with profile
//                    VStack(spacing: 0) {
//
//                        // Profile section
//                        VStack(spacing: 20) {
//                            // Profile image
//                            Circle()
//                                .fill(Color.gray.opacity(0.3))
//                                .frame(width: 140, height: 140)
//                                .overlay(
//                                    Image(systemName: "person.fill")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.gray)
//                                )
//                                .clipShape(Circle())
//
//                            // Name
//                            Text(viewModel.fullName ?? "")
//                                .font(.title2)
//                                .fontWeight(.medium)
//                                .foregroundColor(.white)
//
//                            // Rating stars
//                            HStack(spacing: 12) {
//                                ForEach(0..<5) { index in
//                                    Circle()
//                                        .fill(Color.white.opacity(0.7))
//                                        .frame(width: 35, height: 35)
//                                        .overlay(
//                                            Image(systemName: "star.fill")
//                                                .font(.system(size: 16))
//                                                .foregroundColor(.blue)
//                                        )
//                                }
//                            }
//                        }
//                        .padding(.top, 90) // Spacing from the top
//                    }
//                    .background(AppSetting.ColorSetting.appBg)
//                    .frame(maxHeight: 500) // Fixed height for top section
//
//
//
//                    // Scrollable content: Balance and Wallet Action Buttons
//                    ScrollView {
//                        VStack(spacing: 0) {
//                            // Balance Section
//                            VStack {
//                                Text(viewModel.balance ?? "0")
//                                    .font(.system(size: 36, weight: .bold))
//                                    .foregroundColor(.black)
//                                    .padding(.vertical, 25)
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.white)
//                            }
//
//                            // Action Buttons Section
//                            VStack(spacing: 12) {
//                                NavigationLink(destination: DepositView()){ Text("Deposite")
//                                        .font(.system(size: 18, weight: .medium))
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 55)
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                }
//                                NavigationLink(destination: PayoutView()){ Text("PAYOUT")
//                                        .font(.system(size: 18, weight: .medium))
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 55)
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                }
//                                NavigationLink(destination: DepositView()){ Text("TRANSFER")
//                                        .font(.system(size: 18, weight: .medium))
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 55)
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                }
//                                NavigationLink(destination: TransactionHistoriesView()){ Text("HISTORIES")
//                                        .font(.system(size: 18, weight: .medium))
//                                        .foregroundColor(.white)
//                                        .frame(maxWidth: .infinity)
//                                        .frame(height: 55)
//                                        .background(Color.blue)
//                                        .cornerRadius(8)
//                                }
//
//                            }
//                            .padding(.horizontal, 30)
//                            .padding(.top, 25)
//                            .padding(.bottom, 40)
//                        }
//                    }
//                }
//            }
//        }
//        .navigationBarTitle("Payment", displayMode: .inline)  // Set the navigation title
//        .toolbar {
//            // Menu button (left side of the navigation bar)
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    withAnimation(.easeInOut(duration: 0.3)) {
//                        onSildeMenuTap()
//                    }
//                }) {
//                    Image(systemName: "line.horizontal.3")
//                        .font(.title2)
//                        .foregroundColor(.white)
//                }
//            }
//
//            // Set navigation bar title color to white
//            ToolbarItem(placement: .principal) {
//                Text("Payment")
//                    .font(.title3)
//                    .foregroundColor(.white)  // Title color set to white
//            }
//        }
//        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//        .background(
//            Color.blue
//                .edgesIgnoringSafeArea(.top)
//                .frame(height: 0)
//        ) // Optional: For visual consistency (header background)
//        .ignoresSafeArea()
//    }
//}


#Preview {
    NavigationStack {
        PaymentView(onSildeMenuTap: {})
        
    }
}
