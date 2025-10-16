//
//  WebView.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
 

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
         let htmlContent =  try? StorageManager.shared.getAppConfig()?.termsAndCondition ?? "<p>No Content</p>"
        webView.loadHTMLString(htmlContent ?? "<p>No Content</p>", baseURL: nil)
    }
}

