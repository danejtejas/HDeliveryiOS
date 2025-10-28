//
//  SignatureViewModel.swift
//  HDelivery
//
//  Created by Tejas on 16/10/25.
//

import SwiftUI



@MainActor
class SignatureViewModel: ObservableObject {
    @Published var isLoading = false
  
    @Published var message: String?
    @Published var isSuccess = false

    @Published var tripId: String? =  ""
    @Published var username: String = ""
    @Published var transactionId: String?
    @Published var image: String? = ""
    @Published var receiverSignature: String? = ""
    @Published var showAlert: Bool = false
    
    private let repository: SignatureRepository

    init(repository: SignatureRepository = AppDependencies.shared.makeSignatureRepository()) {
        self.repository = repository
    }
    

    func submit() async {
        isLoading = true
        defer { isLoading = false }

        do {
            
           try validate()
            
            guard  let image = image else  {
                return message = "Please select image"
            }
            
            guard let receiverSignature = receiverSignature else   {
                return message = "Please select signature image"
            }
            
            
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let userId = StorageManager.shared.getUserInfo()?.id ?? ""
           
           
            
            
            let request = ReceiverSignatureRequest(token: token,
                                                   tripId:  tripId ?? "",
                                                   username: username,
                                                   transactionId: transactionId ?? "1334343",
                                                   userId: userId,
                                                   image: image ,
                                                   receiverSignature: receiverSignature)
            
            let response = try await repository.uploadReceiverSignature(request)
            if response.isSuccess{
                isSuccess = true
            } else {
                message = response.message
                isSuccess = false
            }
            showAlert = true
        } catch {
            message = "❌ \(error.localizedDescription)"
            isSuccess = false
            showAlert = true
        }
    }
    
    func validate() throws {
       
       try ValidationManager.shared.validate(fields: [
           "Reciver Name": (value: username, rules: [RequiredRule(fieldName: "Reciver Name")])
               ])
   }
}


