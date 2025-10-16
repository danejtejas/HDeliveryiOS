//
//  Untitled.swift
//  HDelivery
//
//  Created by Tejas on 05/10/25.
//


import Foundation

struct SettingsResponse: Codable {
    let status: String
    let data: AppConfig
    let listJob: [JobType]
    let message: String
    var isSuccess: Bool {
        return status == "success".uppercased()
    }
    enum CodingKeys: String, CodingKey {
        case status, data, message
        case listJob = "list_job"
    }
}

struct AppConfig: Codable {
    let signUpStartPoint: String
    let adminEmail: String
    let distance: String
    let driverShareBonus: String
    let passengerShareBonus: String
    let minRedeemAmount: String
    let minTransferAmount: String
    let cancellationFee: String
    let driverEarn: String
    let adminPhoneNumber: String
    let timeToSendRequestAgain: String
    let callToAction: String
    let termsAndCondition: String
    let maxTimeSendRequest: String
    let estimateFareSpeed: String
    let ppmOfLinkI: String
    let ppmOfLinkII: String
    let ppmOfLinkIII: String
    let ppkOfLinkI: String
    let ppkOfLinkII: String
    let ppkOfLinkIII: String
    let sfOfLinkI: String
    let sfOfLinkII: String
    let sfOfLinkIII: String

    enum CodingKeys: String, CodingKey {
        case signUpStartPoint = "sign_up_start_point"
        case adminEmail = "admin_email"
        case distance
        case driverShareBonus = "driver_share_bonus"
        case passengerShareBonus = "passenger_share_bonus"
        case minRedeemAmount = "min_redeem_amount"
        case minTransferAmount = "min_transfer_amount"
        case cancellationFee = "cancellation_fee"
        case driverEarn = "driver_earn"
        case adminPhoneNumber = "admin_phone_number"
        case timeToSendRequestAgain = "time_to_send_request_again"
        case callToAction = "call_to_action"
        case termsAndCondition = "terms_and_condition"
        case maxTimeSendRequest = "max_time_send_request"
        case estimateFareSpeed = "estimate_fare_speed"
        case ppmOfLinkI = "ppm_of_link_i"
        case ppmOfLinkII = "ppm_of_link_ii"
        case ppmOfLinkIII = "ppm_of_link_iii"
        case ppkOfLinkI = "ppk_of_link_i"
        case ppkOfLinkII = "ppk_of_link_ii"
        case ppkOfLinkIII = "ppk_of_link_iii"
        case sfOfLinkI = "sf_of_link_i"
        case sfOfLinkII = "sf_of_link_ii"
        case sfOfLinkIII = "sf_of_link_iii"
    }
}

struct JobType: Codable {
    let link: String
    let name: String
    let startFare: String
    let feePerMinute: String
    let feePerKilometer: String
    let orderNumber: String
    let image: String
    let imgMarker: String
    let pickUpAtA: String
    let workAtB: String
    let taskRate: String
    let receiveAllRequest: Bool
    let disableSignature: Bool
    let estimateCostIsFinal: Bool
    let taskDefaultTime: String

    enum CodingKeys: String, CodingKey {
        case link, name, startFare, feePerMinute, feePerKilometer, orderNumber, image, imgMarker, pickUpAtA, workAtB, taskRate, taskDefaultTime
        case receiveAllRequest = "ReceiveAllRequest"
        case disableSignature = "DisableSignature"
        case estimateCostIsFinal = "EstimateCostIsFinal"
    }
}
