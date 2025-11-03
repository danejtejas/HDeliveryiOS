//
//  ShowDistanceView.swift
//  HDelivery
//
//  Created by Tejas on 03/11/25.
//

import SwiftUI


struct ShowDistanceView: View {
    @Binding var isPresented: Bool
    var totalDistance: String
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
               
                Text("Trip distance \(totalDistance) km — is the delivery done?")
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
                        Text("Done")
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
    ShowDistanceView(isPresented: .constant(true), totalDistance: "100", onBookNow: {})
}
