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
                                Image(systemName: "line.horizontal.3")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    // Title Customization
                    ToolbarItem(placement: .principal) {
                        Text("Terms and Conditions")
                            .foregroundColor(.white)  // Title color set to white
                            .font(.system(size: 22, weight: .medium))
                    }
                }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white) // ensure back button tint color is white
        .toolbarBackground(AppSetting.ColorSetting.navigationBarBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}







#Preview {
    TermConditionView()
}
