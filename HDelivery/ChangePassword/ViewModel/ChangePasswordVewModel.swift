//
//  ChangePasswordVewModel.swift
//  HDelivery
//
//  Created by Tejas on 08/10/25.
//

import SwiftUI

@MainActor
class ChangePasswordViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isChanged = false
    @Published var message: String?

    private let repository: UserRepository

    init(repository: UserRepository =  AppDependencies.shared.makeUserRepository()) {
        self.repository = repository
    }
    func changePassword(oldPassword: String, newPassword: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            guard let token = try StorageManager.shared.getAuthToken()  else  { return}
            let response = try await repository.changePassword(
                token: token,
                oldPassword: oldPassword,
                newPassword: newPassword
            )

            message = response.message
            isChanged = (response.status == "SUCCESS")
        } catch {
            message = "❌ \(error.localizedDescription)"
        }
    }
}

