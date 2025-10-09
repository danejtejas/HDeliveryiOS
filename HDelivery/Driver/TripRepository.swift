//
//  Triprepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//

protocol TripRepository {
    func createTrip(_ request: CreateTripRequest) async throws -> APIResponse<String>
    
    func confirmTrip(_ request: DriverConfirmRequest) async throws -> APIResponse<TripData?>
    func startTrip(token: String, tripId: String) async throws -> APIResponse<String>
    func endTrip(token: String, tripId: String, distance: String) async throws -> APIResponse<String>
    func cancelTrip(token: String, tripId: String) async throws -> APIResponse<String>
    func cancelRequest(token: String, driver: String) async throws -> APIResponse<String>
    
    func showMyUserRequests(token: String, driver: String?) async throws -> APIResponse<[TripDetailResponse]>
    func showMyDriverRequests(token: String) async throws -> APIResponse<[TripDetailResponse]>
    
    func driverArrived(token: String, tripId: String) async throws -> APIResponse<TripData>
    func changeStatus(token: String, tripId: String, status: String) async throws -> APIResponse<String>
    func showTripDetail(token: String, tripId: String) async throws -> APIResponse<TripDetail>
    func showDistance(token: String, tripId: String) async throws -> APIResponse<String>
}
