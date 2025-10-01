//
//  HomeView.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI
import GooglePlaces

struct HomeView : View {
    
    @State private var pickupAddress = ""
    @State private var deliveryAddress = ""
    @State private var isEditingPickup = false
    @State private var isEditingDelivery = false
    @State var tab = MenuOption.home
    
    var onSildeMenuTap : () -> Void
    
    @StateObject private var service = GooglePlaceService()
    
    @State private var showSearch = false
    @State private var selectedPlace: String = ""
    
    
    var body: some View {
        
        
        ZStack{
            
            GoogleMapView()
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
                        
                        TextField("Enter pickup address", text: $service.query,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.green)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                            .onChange(of: service.query) { newValue in
                                print("Name changed to \(newValue)!")
                                showSearch = newValue.isEmpty ? false : true
                                
                            }
                        
                        
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
            .overlay {
                if showSearch {
                    GeometryReader { geo in
                        PlaceSearchOverlay(predictions: service.predictions) { selectedValue in
                            print(selectedValue)
                            //                        service.query = selectedValue
                            showSearch = false
                        }
                        .frame(height: 400)
                        .padding(EdgeInsets(top: 120, leading: 20, bottom: 20, trailing: 20))
                    }
                }
            }
            
        }.animation(.easeIn, value: showSearch)
    }

}


#Preview {
    NavigationView{
        HomeView(onSildeMenuTap: {})
    }
}



struct PlaceSearchOverlay: View {
    var predictions: [GMSAutocompletePrediction]   // passed from parent
    var onSelect: (String) -> Void                 // callback to parent
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(Array(predictions.enumerated()), id: \.element.placeID) { index, prediction in
                    
                        // Label
                        
                    VStack(alignment: .leading) {
                        Text(prediction.attributedPrimaryText.string)
                            .font(.body)
                        if let secondary = prediction.attributedSecondaryText?.string {
                            Text(secondary)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .onTapGesture {
                        onSelect(prediction.attributedFullText.string)
                    }
                    if index != predictions.count - 1 {
                        Divider()
                    }
                   
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}



