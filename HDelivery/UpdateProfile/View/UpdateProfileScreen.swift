//
//  UpdateProfileScreen.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI
import PhotosUI
import ToastSwiftUI


struct UpdateProfileScreen: View {
    
    @State private var selectedPhoto: PhotosPickerItem? = nil
    
    @StateObject private var viewModel = UpdateProfileViewModel()
    
    @State private var avatarImage: Image? = nil
    
    @Environment(\.presentationMode) var presentationMode

    @State private var showCropView = false
    
    @State private var tempImage: UIImage? = nil
    
  
    
    @State private var selectedOption = "Option 1"
    @State private var tempSelection = "Option 1"
    @State private var showPicker = false

  

    
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
                        
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 12) {
                                Image(systemName: "building.2")
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                
                                Text("State")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                            }
                            Button(action : {
                                tempSelection = selectedOption
                                showPicker = true
                            }) {
                                
                                HStack {
                                    Text(viewModel.state .isEmpty ? "Select State" : viewModel.state)
                                        .foregroundColor(viewModel.state.isEmpty ? .gray : .white)
                                    Spacer()
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 12)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.white.opacity(0.5), lineWidth: 1)
                                )
                                
                            }
                            
                           
                        }
                        
                        
                        

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
        .onAppear(perform: {
            Task{
                await viewModel.getCity()
            }
        })
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
        .sheet(isPresented: $showPicker) {
            VStack {
                // Toolbar with Cancel / Done buttons
                HStack {
                    Button("Cancel") {
                        showPicker = false
                    }
                    Spacer()
                    Button("Done") {
                        selectedOption = tempSelection
                        showPicker = false
                    }
                    .bold()
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))

                Divider()

                // The actual picker
                Picker("Select States", selection: $viewModel.stateId) {
                    ForEach(viewModel.states) { op in
                        Text(op.stateName).tag(op.id)
                    }
                }
                .labelsHidden()
                .pickerStyle(WheelPickerStyle())
                .frame(maxHeight: 200)
                .padding(.bottom, 30)
               
                // Whenever selection changes, update the name automatically
                .onChange(of: viewModel.stateId) { oldValue, newValue in
                    if let id = newValue,
                       let state = viewModel.states.first(where: { $0.id == id }) {
                        viewModel.state = state.stateName
                    } else {
                        viewModel.state = ""
                    }
                }
            }
            .presentationDetents([.height(300)]) // iOS 16+ only
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


import SwiftUI

struct StateOption: Identifiable, Hashable {
    let id: Int
    let stateName: String
}

//@MainActor
//class ViewModel: ObservableObject {
//    @Published var states: [StateOption] = [
//        StateOption(id: 1, stateName: "California"),
//        StateOption(id: 2, stateName: "Texas"),
//        StateOption(id: 3, stateName: "Florida")
//    ]
//    
//    @Published var selectedStateId: Int? = nil
//    @Published var selectedStateName: String = ""
//}

//struct StatePickerView: View {
//    @StateObject private var viewModel = ViewModel()
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            TextField("Selected State", text: $viewModel.selectedStateName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .disabled(true)
//            
//            Picker("Select State", selection: $viewModel.selectedStateId) {
//                Text("Select a state").tag(Int?.none)
//                ForEach(viewModel.states, id: \.id) { state in
//                    Text(state.stateName).tag(Optional(state.id))
//                }
//            }
//            .pickerStyle(MenuPickerStyle())
//            
//            if let id = viewModel.selectedStateId {
//                Text("Selected ID: \(id)")
//            }
//        }
//        .padding()
//        // ✅ Updated onChange syntax (iOS 17+)
//        .onChange(of: viewModel.selectedStateId) { oldValue, newValue in
//            if let id = newValue,
//               let state = viewModel.states.first(where: { $0.id == id }) {
//                viewModel.selectedStateName = state.stateName
//            } else {
//                viewModel.selectedStateName = ""
//            }
//        }
//    }
//}
