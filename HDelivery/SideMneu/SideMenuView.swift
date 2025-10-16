//
//  SideMenuView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI

enum MenuOption: String, CaseIterable, Identifiable {
    case home = "HOME"
    case profile = "PROFILE"
    case payment = "PAYMENT"
    case share = "SHARE"
    case help = "HELP"
    case online = "ONLINE"
    case tasksHistories = "TASKS HISTORIES"
    case asTasker = "AS TASKER"
    case changePassword = "CHANGE PASSWORD"
    case myShareCode = "MY SHARE CODE"
    case promotions = "PROMOTIONS"
    case terms = "TERMS &"
    case logout = "LOGOUT"
   
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .profile: return "person.fill"
        case .payment: return "creditcard.fill"
        case .share: return "square.and.arrow.up"
        case .help: return "questionmark.circle.fill"
        case .tasksHistories: return "arrow.clockwise"
        case .asTasker: return "car.fill"
        case .changePassword: return "lock.fill"
        case .myShareCode: return "arrowshape.turn.up.right.fill"
        case .promotions: return "tag.fill"
        case .terms: return "info.circle.fill"
        case .logout: return "power"
        case .online:  return "arrowshape.turn.up.right.fill"
            
        }
    }
}


struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedTab: MenuOption
    @StateObject private var viewModel: SideMenuViewModel = SideMenuViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Profile Section
           
            
            VStack(spacing: 8) {
                if viewModel.prfileImageUrl == nil {
                    Image("user")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.top, 40)
                } else {
                    AsyncImage(url: viewModel.prfileImageUrl )
//                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.top, 40)
                }

                    
                
                Text(viewModel.fullName ?? "Test Name")
                    .foregroundColor(.white)
                    .font(.headline)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 20)
            //            .background(Color.blue)
            
            // Menu List
            List {
                ForEach(MenuOption.allCases) { option in
                    Button {
                        withAnimation {
                            self.selectedTab = option
                            isShowing = false
                        }
                    } label: {
                        SideMenuRow(icon: option.icon, title: option.rawValue)
//                            .background(Color.blue)
//                            .border(.brown, width: 1)
                    }
                    
                    .listRowBackground( AppSetting.ColorSetting.appBg)
                }
            }
           
            .listStyle(.plain)
            .background( AppSetting.ColorSetting.appBg)
            
        }
        .background( AppSetting.ColorSetting.appBg.ignoresSafeArea().ignoresSafeArea())
        .navigationBarHidden(true)
        
    }
}

struct SideMenuRow: View {
    var icon: String
    var title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .font(.title2)
            
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .medium))
        }
        .listRowBackground(Color.clear)
    }
}




#Preview {
    SideMenuView(
        isShowing: .constant(true),                 // Always visible in preview
        selectedTab: .constant(.home)               // Default tab in preview
    )
}
