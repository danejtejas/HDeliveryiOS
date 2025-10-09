////
////  model.swift
////  HDelivery
////
////  Created by Tejas on 07/10/25.
////
//
//import Foundation
//
//

import Foundation





struct TripData: Codable {
    let id: String
    let passengerId: String
    let link: String
    let startTime: String
    let startLat: String
    let startLong: String
    let endLat: String
    let endLong: String
    let dateCreated: String
    let driverId: String
    let startLocation: String
    let endLocation: String
    let status: String
    let endTime: String
    let distance: String
    let estimateFare: String
    let actualFare: String
    let driverRate: String
    let passengerRate: String
    let driver: DriverData
    let passenger: PassengerData
    let pickUpAtA: String
    let workAtB: String
    let startTimeWorking: String
    let endTimeWorking: String
}

struct DriverData: Codable {
    let driverName: String
    let rate: String
    let identity: String
    let imageDriver: String
    let carPlate: String
    let carImage: String
    let phone: String
}

struct PassengerData: Codable {
    let passengerName: String
    let rate: String
    let imagePassenger: String
    let phone: String
}



struct PrivewData {
    static let shared = PrivewData()
    let tripData = TripData(
        id: "377",
        passengerId: "205",
        link: "2",
        startTime: "",
        startLat: "21.1210272",
        startLong: "72.74198489999999",
        endLat: "23.013734",
        endLong: "72.5917293",
        dateCreated: "2025-10-07 14:11:18",
        driverId: "204",
        startLocation: "Surat International Airport, Surat - Dumas Road, Gaviyer, Surat, Gujarat, India",
        endLocation: "Gita Mandir New Bus Stand, Dharmyug Colony, Gita Mandir, Ahmedabad, Gujarat, India",
        status: "1",
        endTime: "",
        distance: "",
        estimateFare: "1900.00",
        actualFare: "",
        driverRate: "",
        passengerRate: "",
        driver: DriverData(
            driverName: "Tejas Danej",
            rate: "",
            identity: "tedt",
            imageDriver: "http://wiseheartdesign.com/images/articles/default-avatar.png",
            carPlate: "1234",
            carImage: "https://hapihyper.com/admin/upload/car/1759566201204image..png",
            phone: "1234567890"
        ),
        passenger: PassengerData(
            passengerName: "",
            rate: "",
            imagePassenger: "",
            phone: ""
        ),
        pickUpAtA: "1",
        workAtB: "0",
        startTimeWorking: "0",
        endTimeWorking: "0"
    )
}


