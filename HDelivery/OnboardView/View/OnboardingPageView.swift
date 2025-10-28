//
//  OnboardingPageView.swift
//  HDelivery
//
//  Created by user286520 on 9/28/25.
//

import SwiftUI

struct OnboardingPageView: View {
    @State private var currentPage = 0
    private let totalPages = 5
    
    @StateObject private var viewModel = OnboardViewModel()
    
    
    var body: some View {
        
        
        NavigationStack {
            VStack(spacing: 0) {
                // Page Content
                TabView(selection: $currentPage) {
                    // Page 1 - Make Transactions
                    
                    ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                        OnboardingPage(item: item)
                        .tag(index)
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentPage)
                
                // Page Indicators
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.5))
                            .frame(width: 10, height: 10)
                            .scaleEffect(currentPage == index ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.3), value: currentPage)
                    }
                }
                .padding(.vertical, 30)
                
                // MARK: Continue / Next Button
                if currentPage == viewModel.items.count - 1 {
                    NavigationLink(destination: ContentView()) {
                        Text("Continue")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.green)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 30)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .animation(.easeInOut(duration: 0.5), value: currentPage)
                }
            }
            .background(Color(UIColor.systemBackground))
        }.navigationBarBackButtonHidden(true)
            .onAppear {
                Task {
                    
                   await viewModel.getData()
                }
            }
    }
}

struct OnboardingPage: View {
   
    var item : OnboardingItem
    init(item: OnboardingItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Main Illustration
            VStack {
                //
                
                AsyncImage(url: URL(string: item.img)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 250)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                
                
            }
            .frame(height: 200)
//            .background(backgroundColor)
            .cornerRadius(100)
            
            // Text Content
            VStack(spacing: 20) {
                Text(item.name)
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                
                HTMLText(item.description)
             
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}






#Preview{
    OnboardingPageView()

}


struct HTMLText: View {
    let html: String
    
    init(_ html: String) {
        self.html = html
    }
    
    var body: some View {
        if let data = html.data(using: .utf8),
           let attributed = try? AttributedString(
               NSAttributedString(
                   data: data,
                   options: [.documentType: NSAttributedString.DocumentType.html],
                   documentAttributes: nil
               )
           ) {
            Text(attributed)
        } else {
            Text(html)
        }
    }
}




