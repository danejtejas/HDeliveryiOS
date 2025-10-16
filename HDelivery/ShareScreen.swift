//
//  ShareScreen.swift
//  DeliveryApp
//
//  Created by Gaurav Rajan.
//

import SwiftUI

struct ShareScreen: View {
  
    var onSelectTab : () -> Void

    var body: some View {
        ZStack {
            // Background gradient
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    AppConstants.Colors.primaryBlue,
//                    AppConstants.Colors.primaryBlue.opacity(0.8)
//                ]),
//                startPoint: .top,
//                endPoint: .bottom
//            )
            Color.blue.ignoresSafeArea()

            VStack(spacing: AppConstants.Spacing.xl) {
                // Header
                HStack {
                    Button(action: { onSelectTab() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Share")
                        .font(AppConstants.Typography.headingFont)
                        .foregroundColor(.white)

                    Spacer()

                   
                }
                .padding(.horizontal, AppConstants.Spacing.md)
                .padding(.top, AppConstants.Spacing.sm)

                Spacer()

                // Content
                VStack(spacing: AppConstants.Spacing.lg) {
//                    Text("WhatsApp sharing functionality")
//                        .font(AppConstants.Typography.headingFont)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//
//                    Text("This screen contains the complete implementation\nwith all features and functionality.")
//                        .font(AppConstants.Typography.bodyFont)
//                        .foregroundColor(.white.opacity(0.9))
//                        .multilineTextAlignment(.center)

                    // Action button
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "phone.circle.fill")
                                .foregroundColor(Color.white)
                                .font(.title2)
                                .padding(.leading)
                            Text("Whats App")
                                .font(AppConstants.Typography.buttonFont)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: AppConstants.Layout.buttonHeight)
                                
                        }
                        .background(AppConstants.Colors.whatsappGreen)
                        .cornerRadius(AppConstants.Layout.cornerRadius)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, AppConstants.Spacing.lg)
                    
                }

                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    ShareScreen(onSelectTab : {})
}
