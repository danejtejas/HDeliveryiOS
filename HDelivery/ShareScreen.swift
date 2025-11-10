//
//  ShareScreen.swift
//  DeliveryApp
//
//  Created by Gaurav Rajan.
//

import SwiftUI
import ToastSwiftUI

struct ShareScreen: View {
  
    var onSelectTab : () -> Void
    @State var isToastVisible: Bool = false
    @State var toastMessage: String? = ""
    var body: some View {
        ZStack {
            AppSetting.ColorSetting.appBg.edgesIgnoringSafeArea(.all)

            VStack(spacing: AppConstants.Spacing.xl) {
                

                Spacer()

                // Content
                VStack(spacing: AppConstants.Spacing.lg) {
//
                    Button(action: openWhatsApp) {
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
        }.toast(isPresenting: $isToastVisible, message: toastMessage ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .toolbar {
                toolbarContent
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    // Just open WhatsApp (home)
    func openWhatsApp() {
        if let url = URL(string: "whatsapp://") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                toastMessage = "WhatsApp not installed"
                isToastVisible = true
                print("WhatsApp not installed")
            }
        }
    }

    // Open chat with specific phone number
    func openWhatsAppChat(phone: String) {
        let urlString = "https://wa.me/\(phone)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("WhatsApp not installed")
            }
        }
    }
    
}

extension ShareScreen {
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { withAnimation { onSelectTab() } }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Share")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .medium))
            }

           
        }
    }
    
}


#Preview {
    ShareScreen(onSelectTab : {})
}
