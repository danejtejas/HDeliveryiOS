//
//  DriverRepository.swift
//  HDelivery
//
//  Created by Tejas on 03/10/25.
//


// DriverRepository.swift

import Foundation

protocol DriverRepository {
    func registerDriver(_ request: DriverRegisterRequest) async throws -> APIResponse<DriverInfo>
    
    func updateDriverProfile(_ request: UpdateDriverProfileRequest) async throws -> APIResponse<DriverInfo>
    
    func setOnlineStatus(token: String, status: String) async throws -> APIResponse<String>
    
    func updateCoordinate(token: String, lat: String, long: String) async throws -> APIResponse<String>
    
    func getDriverLocation(driverId: String) async throws -> APIResponse<DriverInfo>
    
    func searchDrivers(startLat: String, startLong: String, carType: String, distance: String) async throws -> APIResponse<[DriverInfo]>
}

final class APIDriverRepository: DriverRepository {
    private let network: NetworkClient
    
    init(network: NetworkClient) { self.network = network }
    
    func registerDriver(_ request: DriverRegisterRequest) async throws -> APIResponse<DriverInfo> {
        try await network.execute(request)
    }
    
    func updateDriverProfile(_ request: UpdateDriverProfileRequest) async throws -> APIResponse<DriverInfo> {
        try await network.execute(request)
    }
    
    func setOnlineStatus(token: String, status: String) async throws -> APIResponse<String> {
        try await network.execute(DriverOnlineStatusRequest(token: token, status: status))
    }
    
    func updateCoordinate(token: String, lat: String, long: String) async throws -> APIResponse<String> {
        try await network.execute(UpdateDriverCoordinateRequest(token: token, lat: lat, long: long))
    }
    
    func getDriverLocation(driverId: String) async throws -> APIResponse<DriverInfo> {
        try await network.execute(GetDriverLocationRequest(driverId: driverId))
    }
    
    func searchDrivers(startLat: String, startLong: String, carType: String, distance: String) async throws -> APIResponse<[DriverInfo]> {
        try await network.execute(SearchDriverRequest(startLat: startLat, startLong: startLong, carType: carType, distance: distance))
    }
}
