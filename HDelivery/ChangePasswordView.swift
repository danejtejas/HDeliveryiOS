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
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                
                // MARK: - Top Bar
                ZStack {
                    Text("Change Password")
                        .font(.title2)
                        .foregroundColor(.white)
                        .bold()
                    
                    HStack {
                        Button(action: {
                            // Action for menu
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                    }
                }
//                .frame(height: 60)
                .padding(.top, 40) // for safe area
                
                // MARK: - Form Fields
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
                
                // MARK: - Submit Button
                Button(action: {
                    // handle submit
                }) {
                    Text("SUBMIT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(5)
                }
                .padding(.horizontal, 50)
                .padding(.top, 40)
                
                Spacer()
            }
        }
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
    ChangePasswordView()
}

