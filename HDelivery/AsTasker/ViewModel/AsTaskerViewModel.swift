//
//  AsTaskerViewModel.swift
//  HDelivery
//
//  Created by Tejas on 05/10/25.
//

import SwiftUI

@MainActor
class DriverRegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isRegistered = false
    @Published var message = ""
    @Published var showToast = false
    
    private let repository: DriverRepository
    
    
   @Published  var fullName = ""
   @Published  var phone = ""
   @Published  var email = ""
   @Published  var address = ""
   @Published  var description = ""
   @Published  var plate = ""
   @Published  var methodOfIdentification = ""
   @Published  var modelOfVehicle = ""
   @Published  var brandOfVehicle = ""
   @Published  var yearManufacturer = ""
   @Published  var status = ""
   @Published  var vehicleDocument = ""
   @Published  var identificationDocument = ""
   @Published  var taskType = "move my parcel"
   @Published  var bankName = ""
   @Published  var bankAccountNo = ""
   @Published  var referredBy = ""
   @Published  var showImagePicker1 = false
   @Published  var showImagePicker2 = false
   @Published  var vehicleImage1: UIImage?
   @Published  var vehicleImage2: UIImage?
   @Published  var showMenu = false
    
    @Published  var profileImageUrl = ""
    
    @Published  var postCode = ""
   
    @Published var imageUrl1: String?
    @Published var imageUrl2: String?
    
    
    @Published  var vehicleDocumentBase64 = ""
    @Published  var identificationDocumentBase64  = ""
    
    
    init(repository: DriverRepository =  AppDependencies.shared.makeDriverRepository() ) {
        self.repository = repository
        
        var user = StorageManager.shared.getUserInfo()
        
        
        fullName = user?.fullName ?? ""
        phone = user?.phone  ?? ""
        email = user?.email ?? ""
        address = user?.address ?? ""
//        state = user?.stateName ?? ""
//        city = user?.cityName ?? ""
        postCode = user?.postcode ?? ""
        
        profileImageUrl = user?.image ?? ""
        
       
        
        if let car = StorageManager.shared.getUserInfo()?.car {
            plate = car.carPlate ?? ""
            yearManufacturer = car.year ?? ""
            modelOfVehicle = car.model ?? ""
            brandOfVehicle = car.brand ?? ""
            imageUrl1 =  car.images?.image1 ?? ""
            imageUrl2 = car.images?.image2 ?? ""
            
            
            
        }
        if  let driver = StorageManager.shared.getUserInfo()?.driver {
            
            vehicleDocument = driver.document ?? ""
            identificationDocument = driver.identity ?? ""
            
//            referredBy = driver.referredBy
             status = driver.status ?? ""
            
            let arr = driver.bankAccount?.split(separator: "*") ?? []
            
            if arr.count > 1 {
                bankName = String(arr[0])
            }
            if arr.count > 2 {
                bankAccountNo = String(arr[1])
            }
       }
        
    }
    
    func registerDriver() async {
        isLoading = true
        defer { isLoading = false }
        
        
        do {
            
            guard validate() else { return }
            
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let driverRegisterRequest = DriverRegisterRequest(
                token: token,
                carPlate: plate,
                identity: "Aadhar-567890123456",
                brand: brandOfVehicle,
                model: modelOfVehicle,
                year: yearManufacturer,
                status: status,
                account: "\(self.bankName)*\(self.bankAccountNo)",
                referredBy: referredBy,
                linkType: "2",
                image: self.vehicleImage1?.toBase64() ?? "",
                image2: self.vehicleImage2?.toBase64() ?? "",     // Vehicle photo
                document: identificationDocumentBase64,      // Example driver license / ID PDF
                documentName: identificationDocument,
                documentId:  self.vehicleDocumentBase64,
                documentIdName: self.vehicleDocument
            )

           
        
            
            let response = try await repository.registerDriver(driverRegisterRequest)
            message = response.message ?? ""
            showToast = true
            if response.isSuccess {
                isRegistered = true
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            showToast = true
        }
    }
    
    
    func updateDriver() async {
        isLoading = true
        defer { isLoading = false }
        
        
        do {
            
            guard validate() else { return }
            
            let token = try StorageManager.shared.getAuthToken() ?? ""
            
            let updateDriverProfileRequest = UpdateDriverProfileRequest(
                token: token,
                carPlate: plate,
                identity: "Aadhar-567890123456",
                brand: brandOfVehicle,
                model: modelOfVehicle,
                year: yearManufacturer,
                status: status,
                account: "\(self.bankName)*\(self.bankAccountNo)",
                referredBy: referredBy,
                linkType: "2",
                image: self.vehicleImage1?.toBase64() ?? "",
                image2: self.vehicleImage2?.toBase64() ?? "",     // Vehicle photo
                document: identificationDocumentBase64,      // Example driver license / ID PDF
                documentName: identificationDocument,
                documentId:  self.vehicleDocumentBase64,
                documentIdName: self.vehicleDocument
            )

           
        
            
            let response = try await repository.updateDriverProfile(updateDriverProfileRequest)
            message = response.message ?? ""
            showToast = true
            if response.isSuccess {
                isRegistered = true
            }
        } catch {
            message = "❌ \(error.localizedDescription)"
            showToast = true
        }
    }
    
    
}


extension DriverRegisterViewModel {
    
    
    // MARK: - Validation Function
    func validate() -> Bool {
        if fullName.isEmpty {
            showToast(message: "Please enter your full name.")
            return false
        }
        if phone.isEmpty {
            showToast(message: "Please enter your phone number.")
            return false
        }
        if !isValidEmail(email) {
            showToast(message: "Please enter a valid email address.")
            return false
        }
        if address.isEmpty {
            showToast(message: "Please enter your address.")
            return false
        }
        if plate.isEmpty {
            showToast(message: "Please enter your vehicle plate number.")
            return false
        }
        if methodOfIdentification.isEmpty {
            showToast(message: "Please enter your identification method.")
            return false
        }
        if vehicleDocument.isEmpty {
            showToast(message: "Please upload your vehicle document.")
            return false
        }
//        if identificationDocument.isEmpty {
//            showToast(message: "Please upload your identification document.")
//            return false
//        }
        if bankName.isEmpty {
            showToast(message: "Please enter your bank name.")
            return false
        }
        if bankAccountNo.isEmpty {
            showToast(message: "Please enter your bank account number.")
            return false
        }
        if vehicleImage1 == nil || vehicleImage2 == nil {
            showToast(message: "Please upload both vehicle images.")
            return false
        }
        
        return true
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    private func showToast(message: String) {
        self.message = message
        self.showToast = true
    }
    
    
    
    
}
