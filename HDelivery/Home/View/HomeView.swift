//
//  HomeView.swift
//  HDelivery
//
//  Created by user286520 on 9/29/25.
//

import SwiftUI
import GooglePlaces
import CoreLocation



struct HomeView : View {
    
    @State private var pickupAddress = ""
    @State private var deliveryAddress = ""
    @State private var isEditingLocation = false
    @State private var isEditingDelivery = false
    @State var tab = MenuOption.home
    
    var onSildeMenuTap : () -> Void
    
    @StateObject private var service = GooglePlaceService()
    
    @State private var showSearch = false
    @State private var selectedPlace: String = ""
    @State private var isSelectingFromOverlay = false
    @State private var pickupCoordinate: CLLocationCoordinate2D? = nil
    @State private var dropCoordinate: CLLocationCoordinate2D? = nil
    @State private var currentSearchQuery = ""
    
    @State private var reciverPhoneNumber = ""
    @State private var itemDescription = ""
    
    
    @StateObject private var viewModel = TripViewModel()
    @StateObject private var driverSearchViewModel = DriverSearchViewModel()
    
    
    var body: some View {
        
        
        ZStack{
            
            GoogleMapView(
                pickupCoordinate: pickupCoordinate,
                dropCoordinate: dropCoordinate,
            )
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
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.green)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                            .onTapGesture {
                                isEditingLocation = true
                                isEditingDelivery = false
                            }
                            .onChange(of: pickupAddress) { newValue in
                                print("Pickup address changed to \(newValue)!")
                                if isSelectingFromOverlay { return }
                                isEditingLocation = true
                                isEditingDelivery = false
                                currentSearchQuery = newValue
                                service.query = newValue
                                showSearch = newValue.isEmpty ? false : true
                            }
                        
                        
                        Button {
                            
//                            self.setPickupAddres()
                            
                            
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .frame(width: 50, height: 50,alignment: .center)
                                .foregroundColor(.green)
                        }
                        
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    
                    HStack{
                        Text("B")
                            .frame(width: 50, height: 50,alignment: .center)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20))
                        TextField("Enter Drop Address", text: $deliveryAddress,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                            .onTapGesture {
                                isEditingDelivery = true
                                isEditingLocation = false
                            }
                            .onChange(of: deliveryAddress) { newValue in
                                print("Delivery address changed to \(newValue)!")
                                if isSelectingFromOverlay { return }
                                isEditingDelivery = true
                                isEditingLocation = false
                                currentSearchQuery = newValue
                                service.query = newValue
                                showSearch = newValue.isEmpty ? false : true
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.red)
                            .font(.system(size: 14))
                            .frame(height: 50)
                            .padding(.leading,10)
                        
                        
                        Button {
//                            self.setDropAddres()
                            
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .frame(width: 50, height: 50,alignment: .center)
                                .foregroundColor(.red)
                        }
                        
                        
                    }
                    .background(Color.white)
                    .shadow(radius: 3)
                    
                    NavigationLink {
                        ItemSelectionView { selectedItem in
                            self.viewModel.selectedItem = selectedItem
                        }
                    } label: {
                        
                        HStack{
                            
                            Text("C")
                                .frame(width: 50, height: 50,alignment: .center)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .font(Font.system(size: 20))
                           
                            
                            
                            TextField("Describe your item", text: $itemDescription,  axis: .vertical)
                                .textFieldStyle(PlainTextFieldStyle())
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
                        TextField("Recevier phone number", text: $reciverPhoneNumber,  axis: .vertical)
                            .textFieldStyle(PlainTextFieldStyle())
                        
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
                        Task {
                            //                            await viewModel.createTrip()
                            await viewModel.createTripRequest(pickupCoordinate: pickupCoordinate, dropCoordinate: dropCoordinate, pickupAddress: pickupAddress, dropAddress: deliveryAddress, receiverPhone: reciverPhoneNumber )
                        }
                        
                        
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
                    .disabled(viewModel.isLoading)
                    .opacity(viewModel.isLoading ? 0.6 : 1.0)
                
                
                
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
            .sheet(isPresented: $viewModel.isSuccess) {
                RequestSendView()
            }
            .overlay {
                if showSearch {
                    GeometryReader { geo in
                        PlaceSearchOverlay(predictions: service.predictions) { selection in
                            print(selection.text)
                            isSelectingFromOverlay = true
                            showSearch = false
                            // decide whether setting pickup or delivery based on focused field
                            if isEditingLocation {
                                pickupAddress = selection.text
                                service.fetchPlaceDetails(placeID: selection.placeID) { result in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success((_, let coord)):
                                            pickupCoordinate = coord
                                            print("Pickup coordinate set: \(coord)")
                                        case .failure(let error):
                                            print("Failed to get pickup coordinate: \(error)")
                                        }
                                    }
                                }
                                isEditingLocation = false
                            }
                            else if isEditingDelivery {
                                deliveryAddress = selection.text
                                service.fetchPlaceDetails(placeID: selection.placeID) { result in
                                    DispatchQueue.main.async {
                                        switch result {
                                        case .success((_, let coord)):
                                            dropCoordinate = coord
                                            print("Drop coordinate set: \(coord)")
                                        case .failure(let error):
                                            print("Failed to get drop coordinate: \(error)")
                                        }
                                    }
                                }
                                isEditingDelivery = false
                            }
                            DispatchQueue.main.async {
                                isSelectingFromOverlay = false
                            }
                        }
                        .frame(height: 400)
                        .padding(EdgeInsets(top: isEditingDelivery  ? 150 : 100, leading: 20, bottom: 20, trailing: 20))
                    }
                }
                if viewModel.isLoading {
                    LoadView()
                }
                
            }
            
        }.animation(.easeIn, value: showSearch)
        
    }
    
    
    
    
    func setPickupAddres() {
//        service.getPlaceID { (result: Result<(String, CLLocationCoordinate2D), Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let (name, coord)):
//                    self.pickupCoordinate = coord
//                    self.pickupAddress = name
//                    print("✅ Pickup coordinate set: \(coord)")
//                case .failure(let error):
//                    print("❌ Failed to get pickup coordinate: \(error.localizedDescription)")
//                }
//            }
//        }
    }
    
    
    func setDropAddres() {
//        service.getPlaceID { (result: Result<(String, CLLocationCoordinate2D), Error>) in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let (name, coord)):
//                    self.dropCoordinate = coord
//                    self.deliveryAddress = name
//                    print("✅ Pickup coordinate set: \(coord)")
//                case .failure(let error):
//                    print("❌ Failed to get pickup coordinate: \(error.localizedDescription)")
//                }
//            }
//        }
    }
    
}


#Preview {
    NavigationView{
        HomeView(onSildeMenuTap: {})
    }
}



struct PlaceSearchOverlay: View {
    var predictions: [GMSAutocompletePrediction]   // passed from parent
    var onSelect: (_ selection: (text: String, placeID: String)) -> Void                 // callback to parent
    
    
    var body: some View {
        GeometryReader { proxy in
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onSelect((text: prediction.attributedFullText.string, placeID: prediction.placeID ?? ""))
                        }
                        if index != predictions.count - 1 {
                            Divider()
                        }
                        
                    }
                }
                .frame(width: proxy.size.width, alignment: .leading)
            }
            .background(Color.white.ignoresSafeArea())
        }
    }
}





