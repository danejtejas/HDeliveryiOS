//
//  PaymentWebView.swift
//  HDelivery
//
//  Created by Tejas on 30/10/25.
//

import SwiftUI
import WebKit

struct PaystackPaymentScreen: View {
    let checkoutURL: String
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        VStack {
            Text("Paystack Payment").font(.headline).padding(.top)
            
            PaymentWebView(urlString: checkoutURL) { success in
                
                // Dismiss automatically after 2s
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
            .frame(maxHeight: .infinity)
           
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()  // Dismiss the view
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)  // White back button color
                        .font(.system(size: 20, weight: .medium))
                }
            }
        }
        
    }
}




struct PaymentWebView: UIViewRepresentable {
    let urlString: String
    let onPaymentCompleted: (Bool) -> Void   // callback when success or failure
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: PaymentWebView
        
        init(parent: PaymentWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            // Detect Paystack success/failure redirect URLs here
            if let url = navigationAction.request.url?.absoluteString {
                print("Navigating to: \(url)")
                
                if url.contains("paystack.com/close") || url.contains("payment/success") {
                    parent.onPaymentCompleted(true)
                    decisionHandler(.cancel)
                    return
                }
                if url.contains("payment/failed") {
                    parent.onPaymentCompleted(false)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        // Initialize WebView
        let webView = WKWebView(frame: .zero, configuration: makeConfig())
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        // ✅ Equivalent settings
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true       // JavaScript enabled
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.configuration.websiteDataStore = .default()                  // Enable DOM storage
        
        webView.navigationDelegate = context.coordinator
        
        // ✅ User agent (like Android’s System.getProperty("http.agent"))
        webView.evaluateJavaScript("navigator.userAgent") { result, error in
            if let ua = result as? String {
                print("User agent: \(ua)")
            }
        }
        
        // ✅ No cache
        webView.configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        // ✅ Background color (like Color.BLACK)
        webView.backgroundColor = UIColor.black
        webView.scrollView.backgroundColor = UIColor.black
        
        // ✅ Load the URL
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
            webView.load(request)
        }
        
        return webView
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    private func makeConfig() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        config.websiteDataStore = .default()
        return config
    }
}


