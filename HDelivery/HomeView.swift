//
//  HomeView.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI

struct HomeView : View {
    
    @State var picketLocation: String = ""
    
    
    @State private var pickupAddress = ""
    @State private var deliveryAddress = ""
    @State private var isEditingPickup = false
    @State private var isEditingDelivery = false
    
    @State var tab = MenuOption.home
    
    var onSildeMenuTap : () -> Void
    
    var body: some View {
        
        
        ZStack{
            
            MapViewWrapper()
                            .edgesIgnoringSafeArea(.all)
            
            
            // MARK: Main Scr
            GeometryReader { geo in
                
                VStack(alignment:.leading,spacing: 20){
                    
                    HStack{
                        Text("A")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Enter pickup address", text: $pickupAddress,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onTapGesture {
                                isEditingPickup = true
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.green)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                        
                        Image(systemName: "location.circle.fill")
                            .frame(width: 50, height: 50,alignment: .center)
                            .foregroundColor(.green)
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    
                    HStack{
                        Text("B")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Enter Drop Address", text: $pickupAddress,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onTapGesture {
                                isEditingPickup = true
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.red)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                        
                        Image(systemName: "location.circle.fill")
                            .frame(width: 50, height: 50,alignment: .center)
                            .foregroundColor(.red)
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    HStack{
                        
                        NavigationLink {
                            ItemSelectionView()
                        } label: {
                            
                            HStack{
                                
                                Text("C")
                                    .frame(width: 50, height: 50,alignment: .center)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20))
                                TextField("Describe your item", text: $pickupAddress,  axis: .vertical)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .onTapGesture {
                                        isEditingPickup = true
                                    }
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.blue)
                                    .font(.system(size: 14))
                                    .frame(height: 50)
                                    .padding(.leading,10)
                                
                                
                            }
                            
                        }

                        
                       
                        
                       
                        
                        
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    HStack(alignment: .center){
                        Text("D")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.brown)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Recevier phone number", text: $pickupAddress,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onTapGesture {
                                isEditingPickup = true
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.brown)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                        
                        Image(systemName: "phone.fill")
                            .frame(width: 50, height: 50,alignment: .center)
                            .foregroundColor(.brown)
                        
                        
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for placing an order
                        print("Order Placed!")
                    }) {
                        Text("Place Order")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)  // Button takes full width
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                }.padding(EdgeInsets(top: 50, leading: 20, bottom: 20, trailing: 20))
                
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .toolbar{
                ToolbarItem(placement: .topBarLeading  ) {
                    Button(action: {
                        withAnimation { onSildeMenuTap() }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
                
                // Title Customization
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .foregroundColor(.white)  // Title color set to white
                        .font(.system(size: 22, weight: .medium))
                }
                
                ToolbarItem(placement: .topBarTrailing  ) {
                    Button(action: {
                        withAnimation {  }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
            .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            
        }
    }
}


#Preview {
    NavigationView{
        HomeView(onSildeMenuTap: {})
    }
}
