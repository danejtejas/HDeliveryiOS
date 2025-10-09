//
//  TripHistory.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//


import Foundation



// MARK: - TripData
struct TripHistory: Codable {
    let id: String
    let passengerId: String
    let passenger: PassengerHistory
    let link: String
    let startTime: String?
    let startLat: String?
    let startLong: String?
    let endLat: String?
    let endLong: String?
    let dateCreated: String?
    let driverId: String
    let driver: DriverHistory
    let startLocation: String?
    let endLocation: String?
    let status: String?
    let endTime: String?
    let distance: String?
    let estimateFare: String?
    let actualFare: String?
    let actualReceive: String?
    let driverRate: String?
    let passengerRate: String?
    let totalTime: String?
    let pickUpAtA: String?
    let workAtB: String?
    let itemList: [String]? // It's an empty array in your JSON
    let startTimeWorking: String?
    let endTimeWorking: String?
    let paymentMethod: String?
    let isWattingConfirm: String?
    let receiverPhone: String?

    // Map JSON keys to Swift variable names
    enum CodingKeys: String, CodingKey {
        case id, passengerId, passenger, link, startTime, startLat, startLong, endLat, endLong, dateCreated, driverId, driver, startLocation, endLocation, status, endTime, distance, estimateFare, actualFare, actualReceive, driverRate, passengerRate, totalTime, pickUpAtA, workAtB
        case itemList = "item_list"
        case startTimeWorking, endTimeWorking, paymentMethod, isWattingConfirm, receiverPhone = "receiver_phone"
    }
}

// MARK: - Passenger
struct PassengerHistory: Codable {
    let id: String
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
    let pickUpAtA: String?
    let workAtB: String?
    let receiverPhone: String?

    enum CodingKeys: String, CodingKey {
        case id, fullName, image, email, description, gender, phone, dob, address, balance, isOnline, rate, rateCount, pickUpAtA, workAtB
        case receiverPhone = "receiver_phone"
    }
}

// MARK: - Driver
struct DriverHistory: Codable {
    let id: String
    let fullName: String?
    let identity: String?
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
    var status : String?

    enum CodingKeys: String, CodingKey {
        case id, fullName, identity, image, email, description, gender, phone, dob, address, balance, isOnline, rate, rateCount, carPlate, carImages
    }
}


