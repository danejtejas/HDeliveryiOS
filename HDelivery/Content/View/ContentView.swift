//
//  ContentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isSideMenuOpen = false
    @State private var selectedTab: MenuOption = .home
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            
            
            ZStack {
                // Main content
                
                switch selectedTab {
                case .home:
                    HomeView( onSildeMenuTap: {
                        isSideMenuOpen.toggle()
                    })
                case .payment:
                    PaymentView(onSildeMenuTap: {
                        isSideMenuOpen.toggle()
                        
                    })
                case .profile:
                    ProfileView(onSildeMenuTap: {
                        isSideMenuOpen.toggle()
                        
                    })
                    
                    
                case .promotions:
                    PromotionsView(onSelectedTab: { isSideMenuOpen.toggle()})
                    
                case .help:
                    HelpScreen(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .share:
                    ShareScreen(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .changePassword:
                    ChangePasswordView( tabSelectMenu: { isSideMenuOpen.toggle()})
                    
                    
                case .myShareCode:
                    ShareCodeView(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .tasksHistories:
                    TaskHistoryScreen(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .asTasker:
                    AsTaskerView(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .online:
                    RequestScreen(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .terms:
                     TermConditionView(onSelectTab: { isSideMenuOpen.toggle()})
                    
                case .logout:
                    Text("Logging out...")
               
                    
                }
                
                
                // Drawer menu
                if isSideMenuOpen {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isSideMenuOpen = false }
                        }
                    
                    HStack {
                        SideMenuView(isShowing: $isSideMenuOpen, selectedTab: $selectedTab)
                            .frame(width: 280)
                            .transition(.move(edge: .leading))
                        Spacer()
                    }
                }
            }.fullScreenCover(isPresented: $viewModel.isNavToGoogleNavigaation) {
//                GoogleMapNavigationView(tripData: $viewModel.tripHistory)
                GoogleMapNavigationView(liveLocationViewModel: LiveLocationViewModel(tripHistory: viewModel.tripHistory))
            }.fullScreenCover(isPresented:$viewModel.isNavToPayment) {
                UserRateView(tripData: viewModel.tripHistory)
            }.fullScreenCover(isPresented: $viewModel.isNavToDriverRate) {
                DriverRateView(tripData: $viewModel.tripHistory)
            }.fullScreenCover(isPresented: $viewModel.isNavToUserGoogleMap) {
                UserGoogleMap(tripData: viewModel.tripHistory)
            }.fullScreenCover(isPresented: $viewModel.isNavUserRequest) {
                RequestScreen(onSelectTab: { })
            }
//            fullScreenCover(isPresented: $viewModel.isNavToPaymentDriver) {
//                ConfirmPaymentView(tripId: viewModel.tripHistory?.id)
//            }
        }
        // MARK: - Notification Handlers
        .onReceive(NotificationCenter.default.publisher(for: .driverConfirmedTrip)) { notificaton in
            print("Driver confirmed ✅")
            
            guard let data =  notificaton.object as? TripHistory else {return}
            
            viewModel.tripHistory = data
            withAnimation {
                viewModel.isNavToUserGoogleMap = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .driverArrived)) { _ in
            print("Driver arrived 🚗")
            withAnimation {
                viewModel.isNavToUserGoogleMap = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .tripStarted)) { _ in
            print("Trip started 🛣️")
            withAnimation {
                viewModel.isNavToUserGoogleMap = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .tripEnded)) { _ in
            print("Trip ended 🏁")
            withAnimation {
                viewModel.isNavToPayment = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .paymentPending)) { _ in
            print("Payment pending 💳")
            withAnimation {
                viewModel.isNavToDriverRate = true
            }
        }
    }
}


#Preview {
    ContentView()
}


