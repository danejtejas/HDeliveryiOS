//
//  APITripRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

import Foundation
import SwiftUI
import Combine

final class APITripRepository: TripRepository {
    
    
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func createTrip(_ request: CreateTripRequest) async throws -> APIResponse<String> {
        try await network.execute(request)
    }
    
    func confirmTrip(_ request: DriverConfirmRequest) async throws -> APIResponse<TripData?> { try await network.execute(request) }
    
    func startTrip(token: String, tripId: String) async throws -> APIResponse<TripHistory?> { try await network.execute(StartTripRequest(token: token, tripId: tripId)) }
    
    func endTrip(token: String, tripId: String, distance: String) async throws -> APIResponse<TripHistory?> { try await network.execute(EndTripRequest(token: token, tripId: tripId, distance: distance)) }
    
    func cancelTrip(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(CancelTripRequest(token: token, tripId: tripId)) }
    
    func cancelRequest(token: String, driver: String) async throws -> APIResponse<String> {
        try await network.execute(CancelRequest(token: token, driver: driver))
    }
    func showMyUserRequests(token: String, driver: String?) async throws -> APIResponse<[TripDetailResponse]> {
        try await network.execute(ShowMyRequestForUser(token: token, driver: driver))
    }
    func showMyDriverRequests(token: String) async throws -> APIResponse<[TripDetailResponse]> {
        try await network.execute(ShowMyRequestForDriver(token: token))
    }
    
    func driverArrived(token: String, tripId: String) async throws -> APIResponse<TripData> {
        try await network.execute(DriverArrivedRequest(token: token, tripId: tripId))
    }
    func changeStatus(token: String, tripId: String, status: String) async throws -> APIResponse<String> { try await network.execute(ChangeStatusRequest(token: token, tripId: tripId, status: status)) }
    
    func showTripDetail(token: String, tripId: String) async throws -> APIResponse<TripHistory> { try await network.execute(ShowTripDetailRequest(token: token, tripId: tripId)) }
    func showDistance(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(ShowDistanceRequest(token: token, tripId: tripId)) }
}
