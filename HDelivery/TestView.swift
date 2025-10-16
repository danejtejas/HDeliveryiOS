//
//  TestView.swift
//  HDelivery
//
//  Created by user286520 on 9/27/25.
//

import SwiftUI





struct TestView: View {
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            // MARK: Main Screen
            NavigationView {
                VStack {
                    Text("Main Content")
                        .font(.largeTitle)
                        .padding()
                    
                    Spacer()
                }
                .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    withAnimation {
                        showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(.blue)
                })
            }
            
//            // MARK: Side Menu
//            if showMenu {
//                
//                
//                SideMenuView()
//                    .frame(width: 300) // Drawer width
//                    
//                    
//            }
        }
    }
}



#Preview {
    TestView()
}
