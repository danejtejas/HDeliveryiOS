//
//  UpdateProfileScreen.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI
import PhotosUI
//import Toast_Swift
//import  AlertToast
import ToastSwiftUI


struct UpdateProfileScreen: View {
    
    @State private var selectedPhoto: PhotosPickerItem? = nil
    
    @StateObject private var viewModel = UpdateProfileViewModel()
    
    @State private var avatarImage: Image? = nil
    
    @Environment(\.presentationMode) var presentationMode

    @State private var showCropView = false
    
    @State private var tempImage: UIImage? = nil
    
    

    
    var body: some View {
        ZStack {
            // Blue background
            AppSetting.ColorSetting.appBg.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    
                    // Profile Avatar Section
                    VStack(spacing: 15) {
                        Button(action: {
                            // Update avatar action
                        }) {
                            
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
                                        } else if  viewModel.profileImageUrl != "",
                                                  let url = URL(string:  viewModel.profileImageUrl ) {
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                        .frame(width: 100, height: 100)
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(Circle())
                                                case .failure:
                                                    Image(systemName: "person.fill")
                                                        .font(.system(size: 50))
                                                        .foregroundColor(.gray)
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
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
                                            await MainActor.run {
                                                tempImage = uiImage
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.showCropView = true
                                            }
                                           
                                        }
                                    }
                                }
                                
                                Text("Tap to update avatar")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            
                            
                            
                        }
                    }
                    .padding(.bottom, 30)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        ProfileFormField(
                            icon: "person",
                            label: "Full Name",
                            text: $viewModel.fullName
                        )
                        
                        ProfileFormField(
                            icon: "phone",
                            label: "Phone",
                            text: $viewModel.phone
                        )
                        
                        ProfileFormField(
                            icon: "envelope",
                            label: "Email",
                            text: $viewModel.email
                        )
                        
                        ProfileFormField(
                            icon: "location",
                            label: "Address",
                            text: $viewModel.address
                        )
                        
                        ProfileFormField(
                            icon: "building.2",
                            label: "State",
                            text: $viewModel.state
                        )
                        
                        ProfileFormField(
                            icon: "location.circle",
                            label: "City",
                            text: $viewModel.city
                        )
                        
                        ProfileFormField(
                            icon: "info.circle",
                            label: "Post code",
                            text: $viewModel.postCode
                        )
                        
                        ProfileFormField(
                            icon: "building.columns",
                            label: "Bank Name",
                            text: $viewModel.bankName
                        )
                        
                        ProfileFormField(
                            icon: "building.columns",
                            label: "Bank Account No",
                            text: $viewModel.bankAccountNo
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }.padding(.top, 20)
            }
        }
       
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Update Profile")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await viewModel.updateProfile()
                    }
                    
                }) {
                    Image(systemName: "doc.text")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
        }
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        
        .overlay {
            if viewModel.isLoading {
                LoadView()
            }
        }.toast(isPresenting: $viewModel.isToastShow, message: viewModel.message ?? "")
        .sheet(item: $tempImage) { image in
                SquareCropView(image: image) { croppedImage in
                    avatarImage = Image(uiImage: croppedImage)
                     
                    if let base64String = croppedImage.toBase64() {
                        viewModel.imageBase64String = base64String
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



extension UIImage : @retroactive Identifiable {
    public var id: Int {
        return 1
    }
}



