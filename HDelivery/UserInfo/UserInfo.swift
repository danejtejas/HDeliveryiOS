//
//  UserInfo.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


import Foundation


struct ShowUserInfoRequest: APIRequest {
    typealias Response = APIResponse<UserInfo>
    var path: String { "api/showUserInfo" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var body: Data? {
//        try? JSONEncoder().encode(["token": token])
        let string = "token=\(token)"
        let data = string.data(using: .utf8)
        return data
    }
}




// MARK: - Trip Detail
import Foundation

struct TripDetailResponse: Codable, Identifiable {
    var id: String?
    var passengerId: String?
    var passenger: Passenger?
    var driverId: String?
    var driver: Driver?
    var requestTime: String?
    var link: String?
    var startTime: String?
    var startLat: String?
    var startLong: String?
    var startLocation: String?
    var endLat: String?
    var endLong: String?
    var endLocation: String?
    var passengerRate: String?
    var estimateFare: String?
    var itemPrice: String?
    var itemList: [DeliverItem]?
    var status: String?
    var isWaitingConfirm: String?

    enum CodingKeys: String, CodingKey {
        case id, passengerId, passenger, driverId, driver, requestTime, link, startTime, startLat, startLong, startLocation, endLat, endLong, endLocation, passengerRate, status
        case estimateFare = "estimate_fare"
        case itemPrice = "item_price"
        case itemList = "item_list"
        case isWaitingConfirm = "isWattingConfirm"
    }

    // ✅ Custom Decoder Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try? container.decode(String.self, forKey: .id)
        passengerId = try? container.decode(String.self, forKey: .passengerId)
        passenger = try? container.decode(Passenger.self, forKey: .passenger)
        driverId = try? container.decode(String.self, forKey: .driverId)
        driver = try? container.decode(Driver.self, forKey: .driver)
        requestTime = try? container.decode(String.self, forKey: .requestTime)
        link = try? container.decode(String.self, forKey: .link)
        startTime = try? container.decode(String.self, forKey: .startTime)
        startLat = try? container.decode(String.self, forKey: .startLat)
        startLong = try? container.decode(String.self, forKey: .startLong)
        startLocation = try? container.decode(String.self, forKey: .startLocation)
        endLat = try? container.decode(String.self, forKey: .endLat)
        endLong = try? container.decode(String.self, forKey: .endLong)
        endLocation = try? container.decode(String.self, forKey: .endLocation)
        passengerRate = try? container.decode(String.self, forKey: .passengerRate)
        estimateFare = try? container.decode(String.self, forKey: .estimateFare)
        itemPrice = try? container.decode(String.self, forKey: .itemPrice)
        itemList = try? container.decode([DeliverItem].self, forKey: .itemList)
        status = try? container.decode(String.self, forKey: .status)
        isWaitingConfirm = try? container.decode(String.self, forKey: .isWaitingConfirm)
        
        if let items = try? container.decode([DeliverItem].self, forKey: .itemList) {
            itemList = items
        } else if let strings = try? container.decode([String].self, forKey: .itemList) {
            // convert string names into dummy Item objects
            itemList = strings.map { DeliverItem(id: UUID().uuidString, qty: "1", itemDesc: "", price: "", name: $0, requestId: nil, type: nil) }
        } else {
            itemList = []
        }
        
        
    }
}


struct DeliverItem: Codable, Identifiable {
    var id: String?
    var qty: String?
    var itemDesc: String?
    var price: String?
    var name: String?
    var requestId: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id, qty, price, name, type
        case itemDesc = "item_desc"
        case requestId = "request_id"
    }
}



// MARK: - User (Passenger)
struct Passenger: Codable {
    var id: String?
    var fullName: String?
    var image: String?
    var email: String?
    var description: String?
    var gender: String?
    var phone: String?
    var dob: String?
    var address: String?
    var balance: String?
    var isOnline: String?
    var rate: String?
    var rateCount: String?
}

// MARK: - Driver
struct Driver: Codable {
    let id: String?
    let fullName: String?
    let image: String?
    let email: String?
    let description: String?
    let gender: String?
    let phone: String?
    let dob: String?
    let address: String?
    let balance: String?
    let isOnline: String?
    let rate: String?
    let rateCount: String?
    let carPlate: String?
    let carImages: CarImages?
}

// MARK: - Car Images
struct CarImages: Codable {
    var image1: String?
    var image2: String?
}

// MARK: - Item (empty array but included for safety)
//struct Item: Codable {}







struct TripDetail: Codable {
    let tripId: String
    let startLat: String
    let startLong: String
    let startLocation: String
    let endLat: String
    let endLong: String
    let endLocation: String
    let estimateDistance: String
    let driverId: String?
    let status: String
    var isWattingConfirm : String = "0"
    var passengerRate : String?
}


struct DriverInfo: Codable {
    let id: String
    let carPlate: String
    let brand: String
    let model: String
    let year: String
    let status: String
    let locationLat: String?
    let locationLong: String?
}


// AuthAPI.swift
// Authentication related API requests

import Foundation

// MARK: - Prepare Login
struct PrepareLoginRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/prepareLogin" }
    var method: HTTPMethod { .post }
    
    let email: String
    
    var body: Data? {
        try? JSONEncoder().encode(["email": email])
    }
}

// MARK: - Authorize Token
struct AuthorizeTokenRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/authorize" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var body: Data? {
        try? JSONEncoder().encode(["token": token])
    }
}

// MARK: - Normal Login
struct LoginNormalRequest: APIRequest {
    typealias Response = APIResponse<LoginResponse>
    var path: String { "api/loginNormal" }
    var method: HTTPMethod { .get }
    
    let email: String
    let password: String
    let gcmId: String
    let ime: String
    let lat: String
    let long: String
    let type: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "gcm_id", value: gcmId),
            URLQueryItem(name: "ime", value: ime),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "long", value: long),
            URLQueryItem(name: "type", value: type)
        ]
    }
}

// MARK: - Social Login
struct LoginSocialRequest: APIRequest {
    typealias Response = APIResponse<LoginResponse>
    var path: String { "api/login" }
    var method: HTTPMethod { .post }
    
    let gcmId: String
    let email: String
    let ime: String
    let type: String
    let lat: String
    let long: String
    let name: String
    let gender: String
    let image: String
    
    var body: Data? {
        try? JSONEncoder().encode([
            "gcm_id": gcmId,
            "email": email,
            "ime": ime,
            "type": type,
            "lat": lat,
            "long": long,
            "name": name,
            "gender": gender,
            "image": image
        ])
    }
}

// MARK: - Logout
struct LogoutRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/logout" }
    var method: HTTPMethod { .post }
    
    let token: String
    
    var body: Data? {
        try? JSONEncoder().encode(["token": token])
    }
}


// UserAPI.swift
// User management related API requests



// MARK: - Register Account
struct RegisterUserRequest: APIRequest {
    typealias Response = APIResponse<UserInfo>
    var path: String { "api/signupAndroid" }
    var method: HTTPMethod { .post }
    
    let fullName: String
    let phone: String
    let email: String
    let password: String
    let address: String
    let city: String
    let country: String
    let postCode: String
    let account: String
    let image: String // base64
    
    var body: Data? {
        try? JSONEncoder().encode([
            "full_name": fullName,
            "phone": phone,
            "email": email,
            "password": password,
            "address": address,
            "city": city,
            "country": country,
            "post_code": postCode,
            "account": account,
            "image": image
        ])
    }
}



// MARK: - Update Profile
struct UpdateProfileRequest: APIRequest {
    typealias Response = APIResponse<UserInfo>
    var path: String { "api/updateProfile" }
    var method: HTTPMethod { .post }
    
    let token: String
    let description: String?
    let fullName: String?
    let address: String?
    let phone: String?
    let cityId: String?
    let stateId: String?
    let account: String?
    let typeDevice: String?
    let image: String? // base64
    
    var body: Data? {
        var dict: [String: Any] = ["token": token]
        if let description = description { dict["description"] = description }
        if let fullName = fullName { dict["full_name"] = fullName }
        if let address = address { dict["address"] = address }
        if let phone = phone { dict["phone"] = phone }
        if let cityId = cityId { dict["cityId"] = cityId }
        if let stateId = stateId { dict["stateId"] = stateId }
        if let account = account { dict["account"] = account }
        if let typeDevice = typeDevice { dict["type_device"] = typeDevice }
        if let image = image { dict["image"] = image }
        
       return dict.toFormURLEncodedData()
    }
}

// MARK: - Change Password
struct ChangePasswordRequest: APIRequest {
    typealias Response = APIResponse<String>
    var path: String { "api/changePassword" }
    var method: HTTPMethod { .get }
    
    let token: String
    let oldPassword: String
    let newPassword: String
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "oldPassword", value: oldPassword),
            URLQueryItem(name: "newPassword", value: newPassword)
        ]
    }
}





struct UserInfo: Codable {
    var id: String?
    var fullName: String?
    var image: String?
    var email: String?
    var description: String?
    var isActive: String?
    var gender: String?
    var phone: String?
    var dob: String?
    var address: String?
    var balance: String?
    var isOnline: String?
    var passengerRate: String?
    var passengerRateCount: String?
    var stateId: String?
    var stateName: String?
    var cityId: String?
    var cityName: String?
    var typeAccount: String?
    var account: String?
    var driver: DriverInfoData?
    var car: CarInfo?
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, image, email, description, isActive, gender, phone, dob, address,
             balance, isOnline, passengerRate, passengerRateCount, stateId, stateName,
             cityId, cityName, typeAccount, account, driver, car
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = container.decodeSafeString(forKey: .id)
        fullName = container.decodeSafeString(forKey: .fullName)
        image = container.decodeSafeString(forKey: .image)
        email = container.decodeSafeString(forKey: .email)
        description = container.decodeSafeString(forKey: .description)
        isActive = container.decodeSafeString(forKey: .isActive)
        gender = container.decodeSafeString(forKey: .gender)
        phone = container.decodeSafeString(forKey: .phone)
        dob = container.decodeSafeString(forKey: .dob)
        address = container.decodeSafeString(forKey: .address)
        balance = container.decodeSafeString(forKey: .balance)
        isOnline = container.decodeSafeString(forKey: .isOnline)
        passengerRate = container.decodeSafeString(forKey: .passengerRate)
        passengerRateCount = container.decodeSafeString(forKey: .passengerRateCount)
        stateId = container.decodeSafeString(forKey: .stateId)
        stateName = container.decodeSafeString(forKey: .stateName)
        cityId = container.decodeSafeString(forKey: .cityId)
        cityName = container.decodeSafeString(forKey: .cityName)
        typeAccount = container.decodeSafeString(forKey: .typeAccount)
        account = container.decodeSafeString(forKey: .account)

        // 👇 Safely decode driver & car — handle both array and object cases
        if let driverObject = try? container.decodeIfPresent(DriverInfoData.self, forKey: .driver) {
            driver = driverObject
        } else if let _ = try? container.decodeIfPresent([DriverInfoData].self, forKey: .driver) {
            driver = nil // API returned empty array []
        }

        if let carObject = try? container.decodeIfPresent(CarInfo.self, forKey: .car) {
            car = carObject
        } else if let _ = try? container.decodeIfPresent([CarInfo].self, forKey: .car) {
            car = nil
        }
    }
}



// MARK: - Driver Details
struct DriverInfoData: Codable {
    var driverRate: String?
    var driverRateCount: String?
    var bankAccount: String?
    var status: String?
    var isOnline: String?
    var document: String?
    var isActive: String?
    var identity: String?
    var updatePending: String?
    var linkType: String?
}




// MARK: - Car Details
struct CarInfo: Codable {
    var id: String?
    var carPlate: String?
    var brand: String?
    var model: String?
    var year: String?
    var status: String?
    var document: String?
    var identificationDocument: String?
    var dateCreated: String?
    var images: CarImages?

    enum CodingKeys: String, CodingKey {
        case id
        case carPlate
        case brand
        case model
        case year
        case status
        case document
        case identificationDocument = "identification_document"
        case dateCreated
        case images
    }
}


extension KeyedDecodingContainer {
    func decodeSafeString(forKey key: Key) -> String? {
        if let value = try? decodeIfPresent(String.self, forKey: key) {
            return value
        } else if let value = try? decodeIfPresent(Int.self, forKey: key) {
            return String(value)
        } else if let value = try? decodeIfPresent(Double.self, forKey: key) {
            return String(value)
        } else if let value = try? decodeIfPresent(Bool.self, forKey: key) {
            return value ? "1" : "0"
        }
        return nil
    }
}
