//
//  Scre.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI

struct ShareCodeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showCopiedAlert = false
    let shareCode = "Rutv201"
    
    @StateObject var viewModel = ShareMyCodeViewModel()
    var onSelectTab : () -> Void
    
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Logo and title section
                VStack(spacing: 20) {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("H Delivery")
                        .font(.system(size: 48, weight: .light))
                        .foregroundColor(.black)
                }
                .padding(.top, 40)
                
                Spacer()
                    .frame(height: 60)
                
                // Earn Money section
                VStack(spacing: 12) {
                    Text("Earn Money")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(.black)
                    
                    Text("Invite a friend and earn money")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 40)
                
                // Share code box
                VStack(spacing: 0) {
                    Text("Tap to copy code")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Text(viewModel.promotionCode ?? "")
                        .font(.system(size: 42, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.26, green: 0.39, blue: 0.71))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .onTapGesture {
                    UIPasteboard.general.string = viewModel.promotionCode
                    showCopiedAlert = true
                }
                
                Spacer()
                    .frame(height: 20)
                
                // Share code button
                Button(action: {
                    shareContent()
                }) {
                    Text("Share Code")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color(red: 0.0, green: 0.8, blue: 0.0))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .onAppear(perform: {
            Task{
                await viewModel.shareCode()
            }
        })
        .overlay(content: {
            if viewModel.isLoading {
                LoadView()
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                   onSelectTab()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("My Share Code")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .alert("Copied!", isPresented: $showCopiedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Share code copied to clipboard")
        }
    
        
    }
    
    func shareContent() {
        let text = "Join H Delivery and use my code \(viewModel.promotionCode) to earn money!"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}

#Preview {
    NavigationStack{
        ShareCodeView(onSelectTab: {})
    }
}
