//
//  TermConditionView.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI





// MARK: - Main View
struct TermConditionView: View {
   
    
    var onSelectTab : () -> Void = { }
    
    var body: some View {
       
            WebView()
                .ignoresSafeArea(.all, edges: .bottom)
                .navigationBarTitle("Terms and Conditions", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            onSelectTab()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.white)
                                Text("Back")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white) // ensure back button tint color is white
        .toolbarBackground(Color.blue, for: .navigationBar) // change bar color
        .toolbarBackground(.visible, for: .navigationBar)
    }
}







#Preview {
    TermConditionView()
}
