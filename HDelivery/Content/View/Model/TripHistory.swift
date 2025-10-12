//
//  TripHistory.swift
//  HDelivery
//
//  Created by Tejas on 09/10/25.
//


import Foundation



// MARK: - TripData
struct TripHistory: Codable, Identifiable {
    let id: String
    let passengerId: String
    let passenger: PassengerHistory?
    let link: String
    let startTime: String?
    let startLat: String?
    let startLong: String?
    let endLat: String?
    let endLong: String?
    let dateCreated: String?
    let driverId: String
    let driver: DriverHistory?
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
    
    var distanceFormat : String {
        return "\(distance ?? "0") km"
    }
    
    var paymentMode : String {
      if let paymentMethod = paymentMethod {
            if paymentMethod == "2" {
              return "By Cash"
          } else {
              return "Online"
          }
        }
        return "NA"
    }
    
    var fareInt : Int {
        return estimateFare.flatMap(Int.init) ?? 0
    }
    
    // MARK: - Custom Initializer
    init(
        id: String = "",
        passengerId: String = "",
        passenger: PassengerHistory? = nil,
        link: String = "",
        startTime: String? = nil,
        startLat: String? = nil,
        startLong: String? = nil,
        endLat: String? = nil,
        endLong: String? = nil,
        dateCreated: String? = nil,
        driverId: String = "",
        driver: DriverHistory? = nil,
        startLocation: String? = nil,
        endLocation: String? = nil,
        status: String? = nil,
        endTime: String? = nil,
        distance: String? = nil,
        estimateFare: String? = nil,
        actualFare: String? = nil,
        actualReceive: String? = nil,
        driverRate: String? = nil,
        passengerRate: String? = nil,
        totalTime: String? = nil,
        pickUpAtA: String? = nil,
        workAtB: String? = nil,
        itemList: [String]? = [],
        startTimeWorking: String? = nil,
        endTimeWorking: String? = nil,
        paymentMethod: String? = nil,
        isWattingConfirm: String? = nil,
        receiverPhone: String? = nil
    ) {
        self.id = id
        self.passengerId = passengerId
        self.passenger = passenger
        self.link = link
        self.startTime = startTime
        self.startLat = startLat
        self.startLong = startLong
        self.endLat = endLat
        self.endLong = endLong
        self.dateCreated = dateCreated
        self.driverId = driverId
        self.driver = driver
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.status = status
        self.endTime = endTime
        self.distance = distance
        self.estimateFare = estimateFare
        self.actualFare = actualFare
        self.actualReceive = actualReceive
        self.driverRate = driverRate
        self.passengerRate = passengerRate
        self.totalTime = totalTime
        self.pickUpAtA = pickUpAtA
        self.workAtB = workAtB
        self.itemList = itemList
        self.startTimeWorking = startTimeWorking
        self.endTimeWorking = endTimeWorking
        self.paymentMethod = paymentMethod
        self.isWattingConfirm = isWattingConfirm
        self.receiverPhone = receiverPhone
    }
    
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        passengerId = try container.decode(String.self, forKey: .passengerId)
        passenger = try container.decode(PassengerHistory.self, forKey: .passenger)
        link = try container.decode(String.self, forKey: .link)
        startTime = try? container.decode(String.self, forKey: .startTime)
        startLat = try? container.decode(String.self, forKey: .startLat)
        startLong = try? container.decode(String.self, forKey: .startLong)
        endLat = try? container.decode(String.self, forKey: .endLat)
        endLong = try? container.decode(String.self, forKey: .endLong)
        dateCreated = try? container.decode(String.self, forKey: .dateCreated)
        driverId = try container.decode(String.self, forKey: .driverId)
        driver = try container.decode(DriverHistory.self, forKey: .driver)
        startLocation = try? container.decode(String.self, forKey: .startLocation)
        endLocation = try? container.decode(String.self, forKey: .endLocation)
        status = try? container.decode(String.self, forKey: .status)
        endTime = try? container.decode(String.self, forKey: .endTime)
        distance = try? container.decode(String.self, forKey: .distance)
        estimateFare = try? container.decode(String.self, forKey: .estimateFare)
        actualFare = try? container.decode(String.self, forKey: .actualFare)
        actualReceive = try? container.decode(String.self, forKey: .actualReceive)
        driverRate = try? container.decode(String.self, forKey: .driverRate)
        passengerRate = try? container.decode(String.self, forKey: .passengerRate)
        
        // 👇 handle totalTime safely
        if let intValue = try? container.decode(Int.self, forKey: .totalTime) {
            totalTime = "\(intValue)"
        } else if let stringValue = try? container.decode(String.self, forKey: .totalTime){
            totalTime = stringValue
        } else {
            totalTime = nil
        }

        pickUpAtA = try? container.decode(String.self, forKey: .pickUpAtA)
        workAtB = try? container.decode(String.self, forKey: .workAtB)
        itemList = try? container.decode([String].self, forKey: .itemList)
        startTimeWorking = try? container.decode(String.self, forKey: .startTimeWorking)
        endTimeWorking = try? container.decode(String.self, forKey: .endTimeWorking)
        paymentMethod = try? container.decode(String.self, forKey: .paymentMethod)
        isWattingConfirm = try? container.decode(String.self, forKey: .isWattingConfirm)
        receiverPhone = try? container.decode(String.self, forKey: .receiverPhone)
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
    
    
    // MARK: - Custom Initializer
    init(
        id: String = "",
        fullName: String? = nil,
        image: String? = nil,
        email: String? = nil,
        description: String? = nil,
        gender: String? = nil,
        phone: String? = nil,
        dob: String? = nil,
        address: String? = nil,
        balance: String? = nil,
        isOnline: String? = nil,
        rate: String? = nil,
        rateCount: String? = nil,
        pickUpAtA: String? = nil,
        workAtB: String? = nil,
        receiverPhone: String? = nil
    ) {
        self.id = id
        self.fullName = fullName
        self.image = image
        self.email = email
        self.description = description
        self.gender = gender
        self.phone = phone
        self.dob = dob
        self.address = address
        self.balance = balance
        self.isOnline = isOnline
        self.rate = rate
        self.rateCount = rateCount
        self.pickUpAtA = pickUpAtA
        self.workAtB = workAtB
        self.receiverPhone = receiverPhone
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
    
    
    // MARK: - Custom Initializer
    init(
        id: String = "",
        fullName: String? = nil,
        identity: String? = nil,
        image: String? = nil,
        email: String? = nil,
        description: String? = nil,
        gender: String? = nil,
        phone: String? = nil,
        dob: String? = nil,
        address: String? = nil,
        balance: String? = nil,
        isOnline: String? = nil,
        rate: String? = nil,
        rateCount: String? = nil,
        carPlate: String? = nil,
        carImages: CarImages? = nil,
        status: String? = nil
    ) {
        self.id = id
        self.fullName = fullName
        self.identity = identity
        self.image = image
        self.email = email
        self.description = description
        self.gender = gender
        self.phone = phone
        self.dob = dob
        self.address = address
        self.balance = balance
        self.isOnline = isOnline
        self.rate = rate
        self.rateCount = rateCount
        self.carPlate = carPlate
        self.carImages = carImages
        self.status = status
    }
}


