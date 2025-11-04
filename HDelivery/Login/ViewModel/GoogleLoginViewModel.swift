//
//  GoogleLoginViewModel.swift
//  HDelivery
//
//  Created by Tejas on 29/10/25.
//

import GoogleSignIn
import GoogleSignInSwift


@MainActor
class GoogleSignInViewModel: ObservableObject {
    @Published var userName: String?
    @Published var userEmail: String?
    @Published var userImage: URL?

    func signIn() async {
        guard let presentingViewController =  UIApplication.shared.rootViewController else {
            print("No presenting view controller found.")
            return
        }

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)
            let user = result.user
            self.userName = user.profile?.name
            self.userEmail = user.profile?.email
            self.userImage = user.profile?.imageURL(withDimension: 100)
        } catch {
            print("Google Sign-In failed: \(error.localizedDescription)")
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.userName = nil
        self.userEmail = nil
        self.userImage = nil
    }
}
