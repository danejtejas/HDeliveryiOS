//
//  DeliveryLoginView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI

struct DeliveryLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @StateObject private var viewModel = LoginViewModel()
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Top section with logo
                    VStack {
                        Spacer()
                        
                        // H Delivery Logo
                        HStack(spacing: 8) {
                            // H Logo
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.green, Color.blue]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                
                                Text("H")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Delivery")
                                .font(.system(size: 36, weight: .light))
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                    }
//                    .frame(height: max(geometry.size.height * 0.6, 300))
                    .frame(height: 350)
                    .background(Color(UIColor.systemBackground))
                    
                    // Bottom section with login form
                    VStack(spacing: 20) {
                        VStack(spacing: 16) {
                            // Email field
                            VStack(alignment: .leading, spacing: 8) {
                                TextField("", text: $email)
                                    .placeholder(when: email.isEmpty) {
                                        Text("Email")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                            
                            // Password field
                            VStack(alignment: .leading, spacing: 8) {
                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Password")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                    .textFieldStyle(PlainTextFieldStyle())
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 30)
                        
                        // Login button and forgot password
                        HStack(spacing: 20) {
                            // Login button
                            Button(action: {
                                // Handle login
                                viewModel.isLoggedIn = true
                            }) {
                                Text("Login")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .frame(width: 120, height: 50)
                                    .background(Color.yellow)
                                    .cornerRadius(8)
                            }
                            
                            Spacer()
                            
                            // Forgot password
                            Button(action: {
                                // Handle forgot password
                            }) {
                                Text("Forgot password?")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .underline()
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // Google login section
                        HStack(spacing: 12) {
                            Text("Or you can login via")
                                .font(.system(size: 16))
                                .foregroundColor(.yellow)
                            
                            Button(action: {
                                // Handle Google login
                            }) {
                                
                                
                                AsyncImage(url: URL(string: "https://developers.google.com/identity/images/g-logo.png")) { image in
                                                                       image
                                                                           .resizable()
                                                                           .aspectRatio(contentMode: .fit)
                                                                           .frame(width: 24, height: 24)
                                                                   } placeholder: {
                                                                       // Fallback if image doesn't load
                                                                       Text("G")
                                                                           .font(.system(size: 16, weight: .bold))
                                                                           .foregroundColor(.blue)
                                                                   }
                                
//                                Image(systemName: "globe")
//                                    .font(.system(size: 24))
//                                    .foregroundColor(.red)
//                                    .frame(width: 40, height: 40)
//                                    .background(
//                                        Circle()
//                                            .fill(
//                                                RadialGradient(
//                                                    gradient: Gradient(colors: [.red, .yellow, .green, .blue]),
//                                                    center: .center,
//                                                    startRadius: 5,
//                                                    endRadius: 20
//                                                )
//                                            )
//                                    )
                            }
                        }
                        .padding(.top, 20)
                        
                        // Create new account
                        Button(action: {
                            // Handle create account
                        }) {
                            Text("CREATE NEW ACCOUNT")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.white)
                        }
                        .padding(.top, 40)
                    }
                    .frame(minHeight: max(geometry.size.height * 0.4, 400))
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.2, green: 0.4, blue: 0.8),
                                Color(red: 0.1, green: 0.3, blue: 0.7)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                   ContentView()
               }
    }
}


#Preview{
    DeliveryLoginView()
}
