//
//  OnboardingPageView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI

struct OnboardingPageView: View {
    @State private var currentPage = 0
    private let totalPages = 5
    
    var body: some View {
        VStack(spacing: 0) {
            // Page Content
            TabView(selection: $currentPage) {
                // Page 1 - Make Transactions
                OnboardingPage(
                    imageName: "exclamationmark.triangle.fill",
                    imageColor: .orange,
                    backgroundColor: Color.yellow.opacity(0.2),
                    title: "MAKE TRANSACTIONS\nWITHIN APP",
                    subtitle: "Please DO NOT make any transactions\nor\narrangements outside this app!",
                    showPhoneIllustration: true
                )
                .tag(0)
                
                // Page 2 - Move My Parcel
                OnboardingPage(
                    imageName: "shippingbox.fill",
                    imageColor: .brown,
                    backgroundColor: Color.clear,
                    title: "MOVE MY PARCEL",
                    subtitle: "Select the \"Move My Parcel\" category\nfor items that weigh 3.5 kg or less.",
                    showClothingItems: true
                )
                .tag(1)
                
                // Page 3 - Medical
                OnboardingPage(
                    imageName: "cross.case.fill",
                    imageColor: .red,
                    backgroundColor: Color.clear,
                    title: "MEDICAL",
                    subtitle: "Select the \"Medical\" category for the\nfast delivery of medically related\nitems that weigh 3.5 kg or less.",
                    showMedicalCase: true
                )
                .tag(2)
                
                // Page 4 - Refunds
                OnboardingPage(
                    imageName: "arrow.triangle.2.circlepath",
                    imageColor: .green,
                    backgroundColor: Color.clear,
                    title: "REFUNDS",
                    subtitle: "All Users are entitled to a 100% refund\nfor failed delivery services. Your\nhappiness is our priority!",
                    showRefundIllustration: true
                )
                .tag(3)
                
                // Page 5 - Welcome
                OnboardingPage(
                    imageName: "h.square.fill",
                    imageColor: .blue,
                    backgroundColor: Color.clear,
                    title: "HAPIHYPER DELIVERY",
                    subtitle: "Welcome to the future of delivery\nservices.",
                    showHLogo: true
                )
                .tag(4)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPage)
            
            // Page Indicators
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                        .frame(width: 10, height: 10)
                        .scaleEffect(currentPage == index ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: currentPage)
                }
            }
            .padding(.vertical, 30)
            
            // Continue Button (only on last page)
            if currentPage == totalPages - 1 {
                Button(action: {
                    // Handle continue action
                    print("Continue to main app")
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .animation(.easeInOut(duration: 0.5), value: currentPage)
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct OnboardingPage: View {
    let imageName: String
    let imageColor: Color
    let backgroundColor: Color
    let title: String
    let subtitle: String
    var showPhoneIllustration = false
    var showClothingItems = false
    var showMedicalCase = false
    var showRefundIllustration = false
    var showHLogo = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Main Illustration
            VStack {
                if showPhoneIllustration {
                    PhoneWarningIllustration()
                } else if showClothingItems {
                    ClothingItemsIllustration()
                } else if showMedicalCase {
                    MedicalCaseIllustration()
                } else if showRefundIllustration {
                    RefundIllustration()
                } else if showHLogo {
                    HLogoIllustration()
                } else {
                    Image(systemName: imageName)
                        .font(.system(size: 80))
                        .foregroundColor(imageColor)
                }
            }
            .frame(height: 200)
            .background(backgroundColor)
            .cornerRadius(100)
            
            // Text Content
            VStack(spacing: 20) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .lineSpacing(2)
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}

struct PhoneWarningIllustration: View {
    var body: some View {
        ZStack {
            // Yellow circle background
            Circle()
                .fill(Color.yellow.opacity(0.3))
                .frame(width: 180, height: 180)
            
            // Phone and hands
            VStack(spacing: -10) {
                // Warning triangle
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.orange)
                
                // Phone illustration
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(width: 60, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    )
                    .overlay(
                        VStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 8, height: 8)
                            Spacer()
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 30, height: 4)
                        }
                        .padding(8)
                    )
                
                // Hands
                HStack(spacing: 20) {
                    // Left hand
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.orange)
                        .rotationEffect(.degrees(-20))
                    
                    // Right hand
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(20))
                }
            }
        }
    }
}

struct ClothingItemsIllustration: View {
    var body: some View {
        HStack(spacing: 20) {
            // Vest
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue)
                .frame(width: 50, height: 70)
                .overlay(
                    VStack {
                        // Vest details
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 30, height: 8)
                            .padding(.top, 8)
                        
                        HStack {
                            Circle()
                                .fill(Color.white.opacity(0.5))
                                .frame(width: 6, height: 6)
                            Circle()
                                .fill(Color.white.opacity(0.5))
                                .frame(width: 6, height: 6)
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                )
            
            // Pants
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray)
                .frame(width: 35, height: 65)
            
            // Bag
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.brown)
                .frame(width: 45, height: 60)
                .overlay(
                    VStack {
                        // Bag handle
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.brown.opacity(0.7))
                            .frame(width: 25, height: 4)
                            .padding(.top, -8)
                        
                        // Bag buckle
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.yellow)
                            .frame(width: 20, height: 6)
                            .padding(.top, 8)
                        
                        Spacer()
                    }
                )
            
            // Shoes
            VStack(spacing: 4) {
                Capsule()
                    .fill(Color.brown)
                    .frame(width: 30, height: 12)
                Capsule()
                    .fill(Color.brown)
                    .frame(width: 30, height: 12)
            }
        }
    }
}

struct MedicalCaseIllustration: View {
    var body: some View {
        ZStack {
            // Medical case body
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red, Color.red.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 100, height: 80)
                .shadow(color: .black.opacity(0.2), radius: 4, x: 2, y: 2)
            
            // Handle
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.blue)
                .frame(width: 40, height: 12)
                .offset(y: -50)
            
            // White cross
            VStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 8, height: 30)
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 30, height: 8)
                    .offset(y: -19)
            }
        }
    }
}

struct RefundIllustration: View {
    var body: some View {
        ZStack {
            // Money stack
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.green)
                .frame(width: 80, height: 50)
                .overlay(
                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 20, height: 20)
                )
            
            // Circular arrows
            Circle()
                .stroke(Color.orange, lineWidth: 8)
                .frame(width: 120, height: 120)
                .overlay(
                    VStack {
                        // Top arrow
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.orange)
                            .offset(y: -60)
                        
                        Spacer()
                        
                        // Bottom arrow
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.red)
                            .offset(y: 60)
                    }
                    .frame(height: 120)
                )
        }
    }
}

struct HLogoIllustration: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green, Color.blue]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 120, height: 120)
            
            Text("H")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
