//
//  HelpScreen.swift
//  DeliveryApp
//
//  Created by Gaurav Rajan.
//

import SwiftUI

struct HelpScreen: View {
   
    @State private var showWebsite = false
    @State private var showTutorials = false
    @State private var showWhatsAppSupport = false

    var onSelectTab : () -> Void
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    AppConstants.Colors.primaryBlue,
                    AppConstants.Colors.primaryBlue.opacity(0.8)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: AppConstants.Spacing.xxl) {
                // Header
                HStack {
                    Button(action: { onSelectTab() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Help")
                        .font(AppConstants.Typography.headingFont)
                        .foregroundColor(.white)

                    Spacer()

                    // Invisible button for symmetry
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .opacity(0)
                    }
                    .disabled(true)
                }
                .padding(.horizontal, AppConstants.Spacing.md)
                .padding(.top, AppConstants.Spacing.sm)

                Spacer()

                // Main content
                VStack(spacing: AppConstants.Spacing.xl) {
                    // Company Info Section
                    VStack(spacing: AppConstants.Spacing.lg) {
                        Text("HapiHyper")
                            .font(AppConstants.Typography.titleFont)
                            .foregroundColor(.white)
                            .fontWeight(.bold)

                        Text("Provides Android, iOS, Web Source Codes and\nDevelopment Services.")
                            .font(AppConstants.Typography.bodyFont)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)

                        Text("Highly Committed to Quality Products and\nExcellent Services.")
                            .font(AppConstants.Typography.bodyFont)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                    }

                    // Action Links Section
                    VStack(spacing: AppConstants.Spacing.lg) {
                        // Website Link
                        Button(action: { showWebsite = true }) {
                            Text("http://hapihyper.com")
                                .font(AppConstants.Typography.bodyFont)
                                .foregroundColor(.yellow)
                                .underline()
                        }
                        .buttonStyle(PlainButtonStyle())

                        // Tutorials Link
                        Button(action: { showTutorials = true }) {
                            Text("Tutorials")
                                .font(AppConstants.Typography.bodyFont)
                                .foregroundColor(.yellow)
                                .underline()
                        }
                        .buttonStyle(PlainButtonStyle())

                        // WhatsApp Support Link
                        Button(action: { showWhatsAppSupport = true }) {
                            Text("WhatsApp support")
                                .font(AppConstants.Typography.bodyFont)
                                .foregroundColor(AppConstants.Colors.whatsappGreen)
                                .underline()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppConstants.Spacing.lg)

                Spacer()
                Spacer()
            }
        }
        .alert("Website", isPresented: $showWebsite) {
            Button("OK") {}
        } message: {
            Text("Website functionality would open http://hapihyper.com")
        }
        .alert("Tutorials", isPresented: $showTutorials) {
            Button("OK") {}
        } message: {
            Text("Tutorials section would be implemented here.")
        }
        .alert("WhatsApp Support", isPresented: $showWhatsAppSupport) {
            Button("OK") {}
        } message: {
            Text("WhatsApp support would be implemented here.")
        }
    }
}

#Preview {
    HelpScreen(onSelectTab: {}  )
}
