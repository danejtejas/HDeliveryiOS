//
//  ContentView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isSideMenuOpen = false
    @State private var selectedTab: MenuOption = .payment
    
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


//struct DrawerMainView: View {
//    @State private var isSideMenuOpen = false
//    @State private var selectedTab: MenuItem = .home
//
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .leading) {
//                // Main content
//                Group {
//                    switch selectedTab {
//                    case .home:
//                        HomeView(onMenuTap: { isSideMenuOpen.toggle() })
//                    case .payment:
//                        PaymentView(onMenuTap: { isSideMenuOpen.toggle() })
//                    case .profile:
//                        ProfileView(onMenuTap: { isSideMenuOpen.toggle() })
//                    default:
//                        PlaceholderView(title: selectedTab.rawValue)
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//                // Hamburger button overlay
//                VStack {
//                    HStack {
//                        Button {
//                            withAnimation { isSideMenuOpen.toggle() }
//                        } label: {
//                            Image(systemName: "line.horizontal.3")
//                                .font(.title2)
//                                .padding(12)
//                                .background(Color.blue.opacity(0.8))
//                                .clipShape(Circle())
//                        }
//                        Spacer()
//                    }
//                    .padding(.leading, 16)
//                    .padding(.top, 44)
//                    Spacer()
//                }
//
//                // Drawer overlay
//                if isSideMenuOpen {
//                    Color.black.opacity(0.35)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation { isSideMenuOpen = false }
//                        }
//
//                    HStack(spacing: 0) {
//                        SideMenuView(isShowing: $isSideMenuOpen,
//                                     selectedTab: $selectedTab)
//                            .frame(width: 280)
//                            .transition(.move(edge: .leading))
//                        Spacer()
//                    }
//                }
//            }
//        } // NavigationStack ends here
//    }
//}
