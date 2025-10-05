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
                    
                case .logout:
                    Text("Logging out...")
                default:
                    Text("\(selectedTab.rawValue) coming soon...")
                        .font(.largeTitle)
                    
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
            }
        }
        
    }
}


#Preview {
    ContentView()
}


