//
//  GoogleLoginViewModel.swift
//  HDelivery
//
//  Created by Tejas on 29/10/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import CoreLocation

@MainActor
class GoogleSignInViewModel: NSObject, ObservableObject {
    @Published var userName: String?
    @Published var userEmail: String?
    @Published var userImage: URL?
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var message: String = ""
    @Published var showToast = false

    
    private let socailLoginRepository:  SocailLogin

    init(socailLoginRepository: SocailLogin = AppDependencies.shared.makeGoogleLoginRepository()) {
        self.socailLoginRepository = socailLoginRepository
    }
   

    func signIn() async {
        guard let presentingViewController = UIApplication.shared.rootViewController else {
            print("⚠️ No presenting view controller found.")
            return
        }

        do {
            isLoading = true

            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
            let user = result.user

            guard let profile = user.profile else {
                print("⚠️ Missing Google profile data.")
                isLoading = false
                return
            }

            self.userName = profile.name
            self.userEmail = profile.email
            self.userImage = profile.imageURL(withDimension: 200)

            // ✅ Step 2: Call your backend API `/api/login` after Google sign-in
            await callSocialLoginAPI()
        }
        catch {
            print("❌ Google Sign-In failed: \(error.localizedDescription)")
            isLoading = false
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.userName = nil
        self.userEmail = nil
        self.userImage = nil
        self.isLoggedIn = false
    }

    // MARK: - Social Login API Call
    private func callSocialLoginAPI() async {
        guard let email = userEmail, let name = userName else {
            message = "Missing Google user info"
            showToast = true
            isLoading = false
            return
        }

        // 🧭 Get user location (optional: can use CLLocationManager)
        let lat = "37.4219"
        let long = "-122.0839"

       

        do {
            
            let gcmToken = try StorageManager.shared.getFCMToken() ?? "unknown"
            let imei = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"

            let request = SocialLoginRequest(
                gcm_id: gcmToken,
                email: email,
                ime: imei,
                type: "2", // iOS platform
                lat: lat,
                long: long,
                name: name,
                gender: "male", // or detect dynamically
                image: userImage?.absoluteString ?? ""
            )
            
            
            let response = try await socailLoginRepository.Login(request: request)
            isLoading = false

            if ((response?.isSuccess) != nil), let user = response?.data {
//                print("✅ Social Login success: \(user.email ?? "")")
                message = response?.message ?? "Login successful"
                isLoggedIn = true
                try StorageManager.shared.storeAuthToken(user.token)
                try StorageManager.shared.storeUserData(user)
               
            } else {
                message = response?.message ?? "Login failed"
            }
        } catch {
            isLoading = false
            message = "Error: \(error.localizedDescription)"
        }

        showToast = true
    }
}



