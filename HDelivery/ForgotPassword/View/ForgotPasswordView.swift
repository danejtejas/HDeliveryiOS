//
//  ForgotPasswordView.swift
//  HDelivery
//
//  Created by Tejas on 12/10/25.
//

import SwiftUI



import SwiftUI



struct ForgotPasswordView: View {
    @State private var email = ""
    @Environment(\.dismiss) private var dismiss
   
     @StateObject var viewModel = ForgotPasswordViewModel()
   
    var body: some View {
       
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Promo Code Input
                    
                    // Description Text
                    Text("Enter the email address associated with your account")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.top,20)
                    
                    TextField("Enter email", text: $email)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                    
                    
                    
                    // Apply Button
                    Button(action: {
                        applyPromoCode()
                    }) {
                        Text("Send Link")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
            .navigationTitle("Forgot Password")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "close.circle")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .principal){
                    Text("Forgot Password")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
            
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .overlay {
                if viewModel.isLoading {
                    LoadView()
                }
            }
            
      
    }
    
    func applyPromoCode() {
        // Handle promo code application
       
        Task {
            await viewModel.forgotPassword(email: email)
        }
        
    }
}








//struct ForgotPasswordView: View {
//    @StateObject private var viewModel = ForgotPasswordViewModel()
//    @State private var email = ""
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Forgot Password")
//                .font(.title)
//                .bold()
//            
//            TextField("Enter your email", text: $email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .textFieldStyle(.roundedBorder)
//            
//            Button("Send Reset Link") {
//                Task {
//                    await viewModel.forgotPassword(email: email)
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .disabled(viewModel.isLoading || email.isEmpty)
//            
//            if viewModel.isLoading {
//                ProgressView("Sending...")
//            }
//            
//            if let message = viewModel.message {
//                Text(message)
//                    .foregroundColor(viewModel.isSuccess ? .green : .red)
//                    .padding(.top)
//            }
//            
//            Spacer()
//        }
//        .padding()
//    }
//}



#Preview {
    ForgotPasswordView()
}
