//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 05/10/25.
//


import SwiftUI

struct LoadView: View {
    var text: String? = nil   // Optional loading text
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
                
                // Show text only if provided
                if let text = text, !text.isEmpty {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top, 5)
                }
            }
            .padding(30)
            .background(Color.black.opacity(0.6))
            .cornerRadius(15)
            .shadow(radius: 10)
        }
        .transition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: true)
    }
}
