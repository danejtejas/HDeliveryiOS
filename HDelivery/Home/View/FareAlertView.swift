//
//  FareAlertView.swift
//  HDelivery
//
//  Created by Tejas on 30/10/25.
//

import SwiftUI



struct FareAlertView: View {
    @Binding var isPresented: Bool
    var fareAmount: String
    var onBookNow: () -> Void
    
    var body: some View {
        ZStack {
            // Dim background
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            
            // Alert box
            VStack(spacing: 16) {
                Text("Estimated fare: \(fareAmount). Do you want to continue?")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                
                Divider()
                
                HStack(spacing: 0) {
                    Button(action: {
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Text("CANCEL")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    
                    Divider()
                        .frame(height: 20)
                    
                    Button(action: {
                        onBookNow()
                        withAnimation {
                            isPresented = false
                        }
                    }) {
                        Text("BOOK NOW")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(6)
            .frame(maxWidth: 280)
            .shadow(radius: 8)
        }
        .animation(.easeInOut, value: isPresented)
    }
}


#Preview {
    FareAlertView(isPresented: .constant(true), fareAmount: "100", onBookNow: {})
}
