//
//  UpdateProfileViewModel.swift
//  HDelivery
//
//  Created by Tejas on 05/10/25.
//

import SwiftUI


@MainActor
class UpdateProfileViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var message: String?
    @Published var updatedUser: UserInfo?

    private let repository: UserRepository

    init(repository: UserRepository =  AppDependencies.shared.makeUserRepository()) {
        self.repository = repository
    }

    func updateProfile(
        fullName: String?,
        phone: String?,
        address: String?,
        cityId: String?,
        stateId: String?,
        description: String?,
        account: String?,
        typeDevice: String?
    ) async {
        isLoading = true
        defer { isLoading = false }

        
        
        

        do {
            
            let token = try StorageManager.shared.getAuthToken() ?? ""
            print("token: \(token)")
            let request = UpdateProfileRequest(
                token: token,
                description: description,
                fullName: fullName,
                address: address,
                phone: phone,
                cityId: cityId,
                stateId: stateId,
                account: account,
                typeDevice: typeDevice,
                image:  DriverTestObject.Base64EncodingOptions()
            )
            
            let response = try await repository.updateProfile(request: request)
            message = response.message
            if response.isSuccess {
                updatedUser = response.data
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
        }
    }
}
