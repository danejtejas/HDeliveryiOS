//
//  ContentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var picketLocation: String = ""
    
    @State private var pickupAddress = "123 Market St, San Francisco, CA"
        @State private var deliveryAddress = "456 Mission St, San Francisco, CA"
        @State private var isEditingPickup = false
        @State private var isEditingDelivery = false
    
    var body: some View {
        
      
        ZStack{
            
//            MapView()
            
          
            
            Rectangle()
                .fill(Color.green)
            // MARK: Main Screen
           
            
            
            
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
                        TextField("Enter pickup address", text: $pickupAddress,  axis: .vertical)
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
                        Text("C")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Enter pickup address", text: $pickupAddress,  axis: .vertical)
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
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    HStack(alignment: .center){
                        Text("D")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.brown)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Enter pickup address", text: $pickupAddress,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onTapGesture {
                                isEditingPickup = true
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.brown)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                        
                        
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                }.padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 20))
                    
            }
            .navigationTitle("home")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    // Menu action
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                }
                            }
                         
                        }
                        .toolbarBackground(Color.black, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
        }
       
        
    }
}

#Preview {
    ContentView()
}

