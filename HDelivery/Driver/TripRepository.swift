//
//  .TripRepositoryswift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


import Foundation

protocol TripRepository {
    func createTrip(_ request: CreateTripRequest) async throws -> APIResponse<String>
    func confirmTrip(_ request: DriverConfirmRequest) async throws -> APIResponse<String>
    func startTrip(token: String, tripId: String) async throws -> APIResponse<String>
    func endTrip(token: String, tripId: String, distance: String) async throws -> APIResponse<String>
    func cancelTrip(token: String, tripId: String) async throws -> APIResponse<String>
    func cancelRequest(token: String, driver: String) async throws -> APIResponse<String>
    func showMyRequests(token: String, driver: String?) async throws -> APIResponse<[TripDetail]>
    func driverArrived(token: String, tripId: String) async throws -> APIResponse<String>
    func changeStatus(token: String, tripId: String, status: String) async throws -> APIResponse<String>
    func showTripDetail(token: String, tripId: String) async throws -> APIResponse<TripDetail>
    func showDistance(token: String, tripId: String) async throws -> APIResponse<String>
}

final class APITripRepository: TripRepository {
    private let network: NetworkClient
    init(network: NetworkClient) { self.network = network }
    
    func createTrip(_ request: CreateTripRequest) async throws -> APIResponse<String> { try await network.execute(request) }
    func confirmTrip(_ request: DriverConfirmRequest) async throws -> APIResponse<String> { try await network.execute(request) }
    func startTrip(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(StartTripRequest(token: token, tripId: tripId)) }
    func endTrip(token: String, tripId: String, distance: String) async throws -> APIResponse<String> { try await network.execute(EndTripRequest(token: token, tripId: tripId, distance: distance)) }
    func cancelTrip(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(CancelTripRequest(token: token, tripId: tripId)) }
    func cancelRequest(token: String, driver: String) async throws -> APIResponse<String> { try await network.execute(CancelRequest(token: token, driver: driver)) }
    func showMyRequests(token: String, driver: String?) async throws -> APIResponse<[TripDetail]> { try await network.execute(ShowMyRequest(token: token, driver: driver)) }
    func driverArrived(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(DriverArrivedRequest(token: token, tripId: tripId)) }
    func changeStatus(token: String, tripId: String, status: String) async throws -> APIResponse<String> { try await network.execute(ChangeStatusRequest(token: token, tripId: tripId, status: status)) }
    func showTripDetail(token: String, tripId: String) async throws -> APIResponse<TripDetail> { try await network.execute(ShowTripDetailRequest(token: token, tripId: tripId)) }
    func showDistance(token: String, tripId: String) async throws -> APIResponse<String> { try await network.execute(ShowDistanceRequest(token: token, tripId: tripId)) }
}
