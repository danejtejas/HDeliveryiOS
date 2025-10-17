//
//  SignupViewModel.swift
//  HDelivery
//
//  Created by Tejas on 02/10/25.
//

import UIKit
import SwiftUI
import PhotosUI
import Combine

class SignupViewModel: ObservableObject {
    
    @Published var signupModel: SignupModel = SignupModel()
    
    @Published var isLoading: Bool = false
    
    var signUpService: SignupService!
    
    @Published var imageBase64String : String = ""
    
    @Published var isToastShow : Bool = false
    
    @Published var message : String = ""
    //    @Published var message : String = ""
    @Published var isSuccess : Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var repository:  SignupRepository
    
    init(repository : SignupRepository = AppDependencies.shared.makeSignupRepository()) {
        self.repository = repository
    }
    
    
    func signup(fullName: String,
                phone: String,
                email: String,
                password: String,
                address: String,
                state: String,
                city: String,
                postCode: String,
                account: String
                
    ) async {
        
        signupModel.fullName = fullName
        signupModel.phone = phone
        signupModel.email = email
        signupModel.password = password
        signupModel.address = address
        signupModel.state =  "7" //state
        signupModel.city = "7"
        signupModel.postCode = postCode
        signupModel.imageData = self.imageBase64String
        signupModel.account = account
        
        
        //        signupModel.fullName = "OM dave"
        //        signupModel.phone = "1234567890"
        //        signupModel.email = "om@gmail.com"
        //        signupModel.password = "1234567"
        //        signupModel.address = "Surat"
        //        signupModel.state =  "7" //state
        //        signupModel.city = "Surat"
        //        signupModel.postCode = "394210"
        //        signupModel.imageData = Base64EncodingOptions()
        //        signupModel.account = "123456"
        //        signupModel.country = "7"
        //
        
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            try validate()
            guard  imageBase64String.isEmpty == false else {
                    message = "Please select image"
                isToastShow = true
                return
            }
            let responsse = try await repository.signup(request: CreateSignupRequestAPIRequest(singupModel : signupModel ))
            isSuccess = responsse.isSuccess
            self.message = responsse.message ?? ""
            self.isToastShow = true
        }
        catch {
            self.message = error.localizedDescription
            self.isToastShow = true
        }
    }
    
}

extension SignupViewModel : FormValidatable  {
    
    
    func validate() throws {

        try ValidationManager.shared.validate(fields: [
            "Full Name": (value:   signupModel.fullName, rules: [RequiredRule(fieldName: "Full Name")]),
            "Phone": (value:  signupModel.phone, rules: [RequiredRule(fieldName: "Phone"), PhoneRule()]),
            "Email": (value:  signupModel.email , rules: [RequiredRule(fieldName: "Email"), EmailRule()]),
            "Password": (value:   signupModel.password , rules: [RequiredRule(fieldName: "Password"), PasswordRule()]),
            "Address": (value: signupModel.address, rules: [RequiredRule(fieldName: "Address")]),
            "PostCode": (value:  signupModel.postCode, rules: [RequiredRule(fieldName: "PostCode"), PostCodedRule()]),
            "City": (value:  signupModel.city, rules: [RequiredRule(fieldName: "City")]),
            "State": (value: signupModel.state, rules: [RequiredRule(fieldName: "State")]),
            "Account": (value: signupModel.account, rules: [AccountRule()])
        ])
    }
    
}
