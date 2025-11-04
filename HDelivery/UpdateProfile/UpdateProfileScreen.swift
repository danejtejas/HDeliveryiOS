//
//  UpdateProfileScreen.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI


struct UpdateProfileScreen: View {
    @State private var fullName: String = "John doe"
    @State private var phone: String = "Phone"
    @State private var email: String = "Email"
    @State private var address: String = "Address"
    @State private var state: String = "Rivers"
    @State private var city: String = "City"
    @State private var postCode: String = "Post code"
    @State private var bankName: String = "Bank Name"
    @State private var bankAccountNo: String = "Bank Account No"
    
    var body: some View {
        ZStack {
            // Blue background
            Color.blue
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        // Empty space for left alignment
                        Spacer()
                        
                        Text("Update Profile")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            // Save/Done action
                        }) {
                            Image(systemName: "doc.text")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    
                    // Profile Avatar Section
                    VStack(spacing: 15) {
                        Button(action: {
                            // Update avatar action
                        }) {
                            Circle()
                                .fill(Color.white.opacity(0.3))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 80, height: 80)
                                        .overlay(
                                            Image(systemName: "person.fill")
                                                .font(.system(size: 40))
                                                .foregroundColor(.gray.opacity(0.7))
                                        )
                                )
                        }
                        
                        Text("Tap to update avatar")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 30)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        ProfileFormField(
                            icon: "person",
                            label: "Full Name",
                            text: $fullName
                        )
                        
                        ProfileFormField(
                            icon: "phone",
                            label: "Phone",
                            text: $phone
                        )
                        
                        ProfileFormField(
                            icon: "envelope",
                            label: "Email",
                            text: $email
                        )
                        
                        ProfileFormField(
                            icon: "location",
                            label: "Address",
                            text: $address
                        )
                        
                        ProfileFormField(
                            icon: "building.2",
                            label: "State",
                            text: $state
                        )
                        
                        ProfileFormField(
                            icon: "location.circle",
                            label: "City",
                            text: $city
                        )
                        
                        ProfileFormField(
                            icon: "info.circle",
                            label: "Post code",
                            text: $postCode
                        )
                        
                        ProfileFormField(
                            icon: "building.columns",
                            label: "Bank Name",
                            text: $bankName
                        )
                        
                        ProfileFormField(
                            icon: "building.columns",
                            label: "Bank Account No",
                            text: $bankAccountNo
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

struct ProfileFormField: View {
    let icon: String
    let label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 20)
                
                Text(label)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            
            TextField("", text: $text)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                )
                .placeholder(when: text.isEmpty) {
                    Text(label)
                        .foregroundColor(.white.opacity(0.7))
                        .font(.system(size: 16))
                        .padding(.horizontal, 15)
                }
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct UpdateProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileScreen()
    }
}
