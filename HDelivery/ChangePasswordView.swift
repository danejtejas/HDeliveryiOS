//
//  ChangePasswordView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State var isSideMenuOpen = false
    
    var tabSelectMenu : () -> Void
    
    var body: some View {
        
        ZStack {
            // Background Color
            AppSetting.ColorSetting.navigationBarBg
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                
                // MARK: - Top Bar (Automatically handled by NavigationBar)
                // The navigation bar title will be automatically placed when using NavigationStack.
                
                // MARK: - Scrollable Form Fields
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        CustomSecureField(title: "Current Password",
                                          placeholder: "Current Password",
                                          text: $currentPassword)
                        
                        CustomSecureField(title: "New Password",
                                          placeholder: "New Password",
                                          text: $newPassword)
                        
                        CustomSecureField(title: "Confirm Password",
                                          placeholder: "Confirm Password",
                                          text: $confirmPassword)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20) // Optional padding for top
                }
                
                // MARK: - Submit Button
                Button(action: {
                    // handle submit logic
                }) {
                    Text("SUBMIT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(5)
                }
                .padding(.horizontal, 50)
                .padding(.top, 40)
                
                Spacer()  // This will push everything above towards the top of the screen
            }
            .padding(.bottom, 20) // Optional to provide extra space at the bottom
        }
        //            .navigationTitle("Change Password") // Navigation Bar Title
        .navigationBarTitleDisplayMode(.inline) // Title style (inline or large)
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text("Change Password")
                    .foregroundColor(.white) // Set the title color to white
                    .font(.title3)
                    .bold()
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        tabSelectMenu()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }.toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        
    }
}


// MARK: - Custom SecureField Row
struct CustomSecureField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
            
            SecureField(placeholder, text: $text)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 1)
                )
                .foregroundColor(.white)
        }
    }
}

#Preview {
    NavigationStack{
        ChangePasswordView( tabSelectMenu: {})
    }
}

