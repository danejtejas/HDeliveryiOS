//
//  PromotionsView.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI


struct PromotionsView: View {
    @State private var promoCode = ""
//    @Environment(\.dismiss) private var dismiss
   
     @StateObject var viewModel = PromotionsViewModel()
    var onSelectedTab : () -> Void
    var body: some View {
       
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Promo Code Input
                    
                    // Description Text
                    Text("Enter the code and it will be\napplied to your next trip.")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                        .padding(.top,20)
                    
                    TextField("Enter Promo code", text: $promoCode)
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
                        Text("Apply")
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
            .navigationTitle("Promotions")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        onSelectedTab()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .principal){
                    Text("Promotions")
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
        print("Applying promo code: \(promoCode)")
        Task {
            await viewModel.applyPromoCodeRequest(code: promoCode)
        }
        
    }
}



#Preview {
    NavigationStack {
        PromotionsView(onSelectedTab: {})
    }
}
