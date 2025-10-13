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
    @Published var message: String? = ""
    @Published var user: UserInfo?

    private let repository: UserRepository
    
    @Published var fullName: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var address: String = ""
    @Published var state: String  = ""
    @Published var city: String = ""
    @Published var postCode: String = ""
    @Published var bankName: String = ""
    @Published var bankAccountNo : String = ""
    @Published var description : String = ""
    
    @Published var imageBase64String : String = ""
    
    @Published var isToastShow: Bool = false
    
    @Published var profileImageUrl : String = ""
    
    init(repository: UserRepository =  AppDependencies.shared.makeUserRepository()) {
        self.repository = repository
        var user = StorageManager.shared.getUserInfo()
        
        
        fullName = user?.fullName ?? ""
        phone = user?.phone  ?? ""
        email = user?.email ?? ""
        address = user?.address ?? ""
        state = user?.stateName ?? ""
        city = user?.cityName ?? ""
        postCode = "post code"
        
        profileImageUrl = user?.image ?? ""
        
        let arr = user?.account?.split(separator: "*") ?? []
        if arr.count > 1 {
            bankName = String(arr[0])
        }
        if arr.count  > 2 {
            bankAccountNo = String(arr[1])
        }
        
    }

    func updateProfile() async {
        isLoading = true
        isToastShow = false
        defer { isLoading = false }
        do {
            
            let cityId = "7"
            let stateId = "1"
            let account = "\(bankName)*\(bankAccountNo)"
            let typeDevice = "2"
            
            
            try self.validate()
            
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
                image: imageBase64String
            )
            
            let response = try await repository.updateProfile(request: request)
            message = response.message ?? ""
            if response.isSuccess {
                user = response.data
            }
            else {
                isToastShow = true
            }
        } catch {
            message = error.localizedDescription
            isToastShow = true
        }
    }
}


extension UpdateProfileViewModel : @preconcurrency FormValidatable  {
    
    
    func validate() throws {
        try ValidationManager.shared.validate(fields: [
            "Full Name": (value: fullName, rules: [RequiredRule(fieldName: "Full Name")]),
            "Phone": (value: phone, rules: [RequiredRule(fieldName: "Phone"), PhoneRule()]),
            "Email": (value: email, rules: [RequiredRule(fieldName: "Email"), EmailRule()]),
            "Address": (value: address, rules: [RequiredRule(fieldName: "Address")]),
            "City": (value: city, rules: [RequiredRule(fieldName: "City")]),
            "State": (value: state, rules: [RequiredRule(fieldName: "State")]),
            "Account": (value: bankAccountNo, rules: [AccountRule()])
        ])
    }
    
}

