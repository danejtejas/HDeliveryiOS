//
//  DeliveryLoginView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI
import ToastSwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct DeliveryLoginView: View {
  
    
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @StateObject private var viewModel = LoginViewModel()
    
    @State private var isForgotPasswordTapped = false
    
    @StateObject private var googleSignInViewModel = GoogleSignInViewModel()
    
    
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Top section with logo
                        VStack {
                            Spacer()
                            
                            Image("splash_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height:150 )
                            
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
                                    //                                viewModel.isLoggedIn = true
                                    viewModel.login(email: email, password: password)
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
                                    self.isForgotPasswordTapped = true
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
                                    
                                    Task {
                                        await googleSignInViewModel.signIn()
                                    }
                                    
                                }) {
                                   Image("google")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .padding(.top, 20)
                            
                            // Create new account
                            
                            NavigationLink(destination: SignUpView()) {
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
            }.toast(isPresenting: $viewModel.isShowToast, message: viewModel.error)
            .toast(isPresenting: $googleSignInViewModel.showToast, message: googleSignInViewModel.message)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            ContentView()
        }
        .fullScreenCover(isPresented: $googleSignInViewModel.isLoggedIn){
            ContentView()
        }
        
        .fullScreenCover(isPresented: $isForgotPasswordTapped) {
            NavigationStack {
                ForgotPasswordView()
            }
            
        }
        .overlay {
            if self.viewModel.isLoading || self.googleSignInViewModel.isLoading {
                LoadView()
            }
            
        }
    }
}


#Preview{
    DeliveryLoginView()
}
