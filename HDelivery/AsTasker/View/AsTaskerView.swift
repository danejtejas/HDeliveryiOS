//
//  Untitled.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//


import SwiftUI

struct AsTaskerView: View {
    @State private var fullName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    @State private var description = ""
    @State private var plate = ""
    @State private var methodOfIdentification = ""
    @State private var modelOfVehicle = ""
    @State private var brandOfVehicle = ""
    @State private var yearManufacturer = ""
    @State private var status = ""
    @State private var vehicleDocument = ""
    @State private var identificationDocument = ""
    @State private var taskType = "move my parcel"
    @State private var bankName = ""
    @State private var bankAccountNo = ""
    @State private var referredBy = ""
    @State private var showImagePicker1 = false
    @State private var showImagePicker2 = false
    @State private var vehicleImage1: UIImage?
    @State private var vehicleImage2: UIImage?
    @State private var showMenu = false
    
    var onSelectTab : () -> Void
    
    @StateObject private var viewModel = DriverRegisterViewModel()
    
    var body: some View {
       
            ZStack {
                Color(red: 0.25, green: 0.38, blue: 0.65)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Profile Image
                        Circle()
                            .fill(Color.black)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 3)
                            )
                            .padding(.top, 20)
                        
                        // Form Fields
                        VStack(spacing: 16) {
                            CustomTextField(icon: "person.fill", label: "Full Name", placeholder: "Full Name", text: $fullName)
                            
                            CustomTextField(icon: "phone.fill", label: "Phone", placeholder: "2222222222", text: $phone, keyboardType: .phonePad)
                            
                            CustomTextField(icon: "envelope.fill", label: "Email", placeholder: "rutvikdemo2@gmail.com", text: $email, keyboardType: .emailAddress)
                            
                            CustomTextField(icon: "mappin.circle.fill", label: "Address", placeholder: "Address", text: $address)
                            
                            CustomTextField(icon: "info.circle.fill", label: "Description", placeholder: "Description", text: $description)
                            
                            CustomTextField(icon: "car.fill", label: "Plate", placeholder: "Plate", text: $plate)
                            
                            CustomTextField(icon: "car.fill", label: "Method of identification", placeholder: "Method of identification", text: $methodOfIdentification)
                            
                            CustomTextField(icon: "trophy.fill", label: "Model of vehicle", placeholder: "Model of vehicle", text: $modelOfVehicle)
                            
                            CustomTextField(icon: "flag.fill", label: "Brand of vehicle", placeholder: "Brand of vehicle", text: $brandOfVehicle)
                            
                            CustomTextField(icon: "calendar", label: "Year manufacturer", placeholder: "Year manufacturer", text: $yearManufacturer)
                            
                            CustomTextField(icon: "arrow.triangle.branch", label: "Status", placeholder: "Status", text: $status)
                            
                            CustomTextField(icon: "doc.fill", label: "Vehicle Document", placeholder: "Vehicle Document", text: $vehicleDocument)
                            
                            CustomTextField(icon: "doc.fill", label: "Identification Document", placeholder: "Identification Document", text: $identificationDocument)
                            
                            CustomTextField(icon: "car.fill", label: "Task Type", placeholder: "move my parcel", text: $taskType)
                            
                            CustomTextField(icon: "building.columns.fill", label: "Bank Name", placeholder: "Bank Name", text: $bankName)
                            
                            CustomTextField(icon: "building.columns.fill", label: "Bank Account No", placeholder: "Bank Account No", text: $bankAccountNo, keyboardType: .numberPad)
                            
                            CustomTextField(icon: "person.fill", label: "Referred by", placeholder: "Referred by", text: $referredBy)
                            
                            // Upload Vehicle Images
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "photo.fill")
                                        .foregroundColor(.white)
                                    Text("Upload Vehicle images")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                }
                                
                                HStack(spacing: 16) {
                                    ImageUploadButton(image: $vehicleImage1, showPicker: $showImagePicker1)
                                    ImageUploadButton(image: $vehicleImage2, showPicker: $showImagePicker2)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.bottom, 30)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("As Tasker")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { onSelectTab() }) {
                            Image(systemName: "line.3.horizontal")
                                .foregroundColor(.white)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                await viewModel.registerDriver()
                            }
                            
                        }) {
                            Image(systemName: "doc.text")
                                .foregroundColor(.white)
                        }
                    }
                }.toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .navigationBarBackButtonHidden(true)
            }
        
        .sheet(isPresented: $showImagePicker1) {
            ImagePicker(image: $vehicleImage1)
        }
        .sheet(isPresented: $showImagePicker2) {
            ImagePicker(image: $vehicleImage2)
        }
    }
}

struct CustomTextField: View {
    let icon: String
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(label)
                    .foregroundColor(.white)
                    .font(.system(size: 16))
            }
            
            TextField(placeholder, text: $text)
                .placeholder(when: text.isEmpty) {
                        Text(placeholder).foregroundColor(.orange)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .foregroundColor(.white)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .keyboardType(keyboardType)
                .autocapitalization(.none)
        }
        .padding(.horizontal, 16)
    }
}

struct ImageUploadButton: View {
    @Binding var image: UIImage?
    @Binding var showPicker: Bool
    
    var body: some View {
        Button(action: { showPicker = true }) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 120)
                    .clipped()
                    .cornerRadius(8)
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("UPLOAD IMAGES")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .frame(width: 150, height: 120)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }
}



#Preview{
    NavigationStack {
        AsTaskerView(onSelectTab: {})
    }
}
