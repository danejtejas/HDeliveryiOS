//
//  SideMenuView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI


import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Profile Section
            VStack(spacing: 8) {
                Image(systemName: "person.circle.fill") // Replace with your profile image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.top, 40)
                
                Text("Rutvik Demo 2")
                    .foregroundColor(.white)
                    .font(.headline)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            .background(Color.blue)
            
            // MARK: Menu List
            List {
               
                    SideMenuRow(icon: "house.fill", title: "HOME")
                    SideMenuRow(icon: "person.fill", title: "PROFILE")
                    SideMenuRow(icon: "creditcard.fill", title: "PAYMENT")
                    SideMenuRow(icon: "square.and.arrow.up", title: "SHARE")
                    SideMenuRow(icon: "questionmark.circle.fill", title: "HELP")
                    SideMenuRow(icon: "arrow.clockwise", title: "TASKS HISTORIES")
                    SideMenuRow(icon: "car.fill", title: "AS TASKER")
                    SideMenuRow(icon: "lock.fill", title: "CHANGE PASSWORD")
                    SideMenuRow(icon: "arrowshape.turn.up.right.fill", title: "MY SHARE CODE")
                    SideMenuRow(icon: "tag.fill", title: "PROMOTIONS")
                    SideMenuRow(icon: "info.circle.fill", title: "TERMS &")
                    SideMenuRow(icon: "power", title: "LOGOUT")
                
            }
            .listStyle(.plain) // Removes grouped background
            .background(Color.blue)
        }
        .background(Color.blue.ignoresSafeArea())
    }
}

struct SideMenuRow: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 24, height: 24)
            
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
        }
        .listRowBackground(Color.blue) // Set row background
    }
}




#Preview {
    SideMenuView()
}
