//
//  SignUpView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var address = ""
    @State private var state = ""
    @State private var city = ""
    @State private var postCode = ""
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var avatarImage: Image? = nil
    
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewmodel: SignupViewModel = .init()
    
    var body: some View {
       
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Avatar Section
                    VStack(spacing: 12) {
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 120, height: 120)
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 100, height: 100)
                                
                                if let avatarImage = avatarImage {
                                    avatarImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.fill")
                                    
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onChange(of: selectedPhoto) { newPhoto in
                            Task {
                                if let data = try? await newPhoto?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    avatarImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                        
                        Text("Tap to update avatar")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        // Full Name
                        FormFieldView(
                            icon: "person.fill",
                            label: "Full Name",
                            placeholder: "John doe",
                            text: $fullName
                        )
                        
                        // Phone
                        FormFieldView(
                            icon: "phone.fill",
                            label: "Phone",
                            placeholder: "Phone",
                            text: $phone
                        )
                        
                        // Email
                        FormFieldView(
                            icon: "envelope.fill",
                            label: "Email",
                            placeholder: "Email",
                            text: $email
                        )
                        
                        // Password
                        FormFieldView(
                            icon: "person.fill",
                            label: "Password",
                            placeholder: "Password",
                            text: $password,
                            isSecure: true
                        )
                        
                        // Address
                        FormFieldView(
                            icon: "location.fill",
                            label: "Address",
                            placeholder: "Address",
                            text: $address
                        )
                        
                        // State
                        FormFieldView(
                            icon: "building.2.fill",
                            label: "State",
                            placeholder: "Rivers",
                            text: $state
                        )
                        
                        // City
                        FormFieldView(
                            icon: "location.circle.fill",
                            label: "City",
                            placeholder: "City",
                            text: $city
                        )
                        
                        // Post Code
                        FormFieldView(
                            icon: "info.circle.fill",
                            label: "Post code",
                            placeholder: "Post code",
                            text: $postCode
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100) // Extra space for bottom navigation
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.2, green: 0.4, blue: 0.8),
                        Color(red: 0.15, green: 0.35, blue: 0.75)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                         dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.title2)
                   
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle save/submit
                        
                        viewmodel.signup(fullName: fullName, phone: phone, email: email, password: password, address: address, state: state, city: city, postCode: postCode)
                        
                    }) {
                        Image(systemName: "doc.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .toolbarBackground(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.2, green: 0.4, blue: 0.8),
                        Color(red: 0.15, green: 0.35, blue: 0.75)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ),
                for: .navigationBar
            )
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .overlay {
                if viewmodel.isLoading {
                    LoadView()
                }
            }
        
       
    }
}

struct FormFieldView: View {
    let icon: String
    let label: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .frame(width: 20)
                
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Group {
                if isSecure {
                    SecureField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholder)
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 16))
                                .italic()
                        }
                } else {
                    TextField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text(placeholder)
                                .foregroundColor(.white.opacity(0.7))
                                .font(.system(size: 16))
                                .italic()
                        }
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 16))
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
            )
        }
    }
}


struct ImagePickerPlaceholder: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "camera.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)
                
                Text("Image Picker")
                    .font(.title2)
                    .padding()
                
                Text("This would open the device's image picker")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .navigationTitle("Select Photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview(body: {
    SignUpView()
})

// Custom placeholder modifier (reusing from previous screen)
//extension View {
//    func placeholder<Content: View>(
//        when shouldShow: Bool,
//        alignment: Alignment = .leading,
//        @ViewBuilder placeholder: () -> Content) -> some View {
//        
//        ZStack(alignment: alignment) {
//            placeholder().opacity(shouldShow ? 1 : 0)
//            self
//        }
//    }
//}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
