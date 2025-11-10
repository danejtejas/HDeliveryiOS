//
//  ProfileView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI



struct ProfileView: View {
    
    //    @State var isSideMenuOpen = false
    //    @State var tab = MenuOption.profile
    
    var onSildeMenuTap : () -> Void
    
    @StateObject var viewModel: ProfileViewModel = .init()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                // MARK: - Header
                ZStack(alignment: .topLeading) {
//                    Color.blue
//                        .ignoresSafeArea(edges: .top)
                    
                    AppSetting.ColorSetting.navigationBarBg.ignoresSafeArea(edges: .top)
                    
                    VStack(spacing: 12) {
                        Spacer().frame(height: 20)
                        
                        // Profile Image
                        if viewModel.prfileImageUrl != nil {
                            
                            AsyncImage(url: viewModel.prfileImageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                        .padding(.top, 20)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .padding(.top, 20)
                                case .failure:
                                    Image(systemName: "user")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                @unknown default:
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 100, height: 100)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                
                                    .padding(.top, 20)
                                }
                            }
                            
                            
                            
                        }
                        else {
                            Image(systemName: "user")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        }
                       
                        
                        // Name
                        Text(viewModel.fullName ?? "")
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        // Rating stars
                        HStack(spacing: 6) {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int((viewModel.rating ?? 0)) ? "star.fill" : "star")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer().frame(height: 20)
                    }
                    .frame(maxWidth: .infinity)
                    
                    //                 Hamburger menu
                    Button(action: {
                        
                        withAnimation(.easeInOut(duration: 0.3)) {
                            //                        isSideMenuOpen.toggle()
                            onSildeMenuTap()
                        }
                        
                    }) {
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
                        
                        ProfileRow(title: "Phone", value: viewModel.phone ?? "")
                        ProfileRow(title: "Email", value: viewModel.email)
                        ProfileRow(title: "Address", value: viewModel.address ?? "")
                        ProfileRow(title: "State", value: viewModel.state)
                        ProfileRow(title: "City", value: viewModel.cityName ?? "")
                        ProfileRow(title: "Post code", value: viewModel.postCode ?? "")
                      
                        if viewModel.typeAccount == "1" {
                            ProfileRow(title: "Car Plate", value: viewModel.carPlate ?? "")
                            ProfileRow(title: "Brand of Vihicle", value: viewModel.yearOfManufacture ?? "")
                            
                            ProfileRow(title: "Model", value: viewModel.make ?? "")
                            
                            ProfileRow(title: "Task Type", value: viewModel.taskType)
                            ProfileRow(title: "Year", value: viewModel.yearOfManufacture ?? "")
                            
                        }
                        

                        
                        ProfileRow(title: "Bank Name", value: viewModel.bankName)
                    
                        ProfileRow(title: "Bank Account No", value: viewModel.bankACNumber ?? "")
                        
                        
                        if viewModel.typeAccount == "1" {
                            
                            NavigationLink(destination: AsTaskerView(isEditing: true, onSelectTab: {}) ) {
                                Text("Update Profile")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }.padding(.trailing, 20)
                            
                        }
                        else {
                            NavigationLink(destination: UpdateProfileScreen()) {
                                Text("Update Profile")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }.padding(.trailing, 20)
                        }
                        
                        
                        
                    }
                    .padding(.leading, 30)
                    .padding(.top, 20)
                    
                }
            }
            
            //
        }
        .onAppear( perform : {
            self.viewModel.fetchData()
        })
        
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
    NavigationView {
        ProfileView(onSildeMenuTap:{})
    }
    //    ProfileRow(title: "hi", value: "12345")
}
