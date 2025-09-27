//
//  ProfileView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI



struct ProfileView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Header
            ZStack(alignment: .topLeading) {
                Color.blue
                    .ignoresSafeArea(edges: .top)
                
                VStack(spacing: 12) {
                    Spacer().frame(height: 20)
                    
                    // Profile Image
                    Image(systemName: "pepeal") //
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    
                    // Name
                    Text("Rutvik Demo 2")
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    // Rating stars
                    HStack(spacing: 6) {
                        ForEach(0..<5) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer().frame(height: 20)
                }
                .frame(maxWidth: .infinity)
                
//                 Hamburger menu
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                }
            }
            .frame(height: 220)
            
            // MARK: - Details Section
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    ProfileRow(title: "Phone", value: "2222222222")
                    ProfileRow(title: "Email", value: "rutvikdemo2@gmail.com")
                    ProfileRow(title: "Address", value: "demo address 2")
                    ProfileRow(title: "State", value: "Cross River")
                    ProfileRow(title: "City", value: "lagos")
                    ProfileRow(title: "Post code", value: "222222")
                    ProfileRow(title: "Bank Name", value: "")
                    ProfileRow(title: "Bank Name", value: "")
                    ProfileRow(title: "Bank Account No", value: "133444")
                    
                }
                .padding(.leading, 30)
                .padding(.top, 20)

            }
        }
    }
}

struct ProfileRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ProfileView()
//    ProfileRow(title: "hi", value: "12345")
}
