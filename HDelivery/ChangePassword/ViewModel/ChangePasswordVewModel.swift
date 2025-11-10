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
    @Published var showTotash: Bool = false

    private let repository: UserRepository

    init(repository: UserRepository =  AppDependencies.shared.makeUserRepository()) {
        self.repository = repository
    }
    func changePassword(oldPassword: String, newPassword: String, confirmPassword: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            
            try validation(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
           
            
            guard let token = try StorageManager.shared.getAuthToken()  else  { return}
            let response = try await repository.changePassword(
                token: token,
                oldPassword: oldPassword,
                newPassword: newPassword
            )

            message = response.message
            isChanged = (response.status == "SUCCESS")
            showTotash = true
        } catch {
            message = "\(error.localizedDescription)"
            showTotash = true
        }
    }
    
    func validation(oldPassword: String, newPassword: String, confirmPassword: String) throws {
        
        let fieldOrders : [String] = ["Old Password", "New Password", "Confirm Password"]
        
      try  ValidationManager.shared.validate(fields: [
            "Old Password": (value: oldPassword, rules: [PasswordRule(fieldName: "Old Password")]),
            "New Password": (value: newPassword, rules: [PasswordRule(fieldName: "New Password")]),
            "Confirm Password": (value: confirmPassword, rules: [ConfirmPasswordRule(newPassword: newPassword, fieldName: "Confirm Password")]),
                ], fieldOrders:  fieldOrders)
    }
}

