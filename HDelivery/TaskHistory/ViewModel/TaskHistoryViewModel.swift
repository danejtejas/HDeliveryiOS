//
//  TaskHistoryViewModel.swift
//  HDelivery
//
//  Created by Tejas on 05/10/25.
//

import SwiftUI

class TaskHistoryViewModel: ObservableObject {
    
    @Published var trips: [TripDetailResponse] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    

    
    /// <#Description#>
    func showMyRequests( ) async {
        isLoading = true
        errorMessage = nil
        let repository: TripRepository = AppDependencies.shared.makeTripRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.showMyRequests(token: token, driver: "0")
            if response.isSuccess, let data = response.data {
                trips = data
            } else {
                errorMessage = response.message
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func showMyTrip( ) async {
        isLoading = true
        errorMessage = nil
        let repository: HistoryRepository = AppDependencies.shared.makeHistoryRepository()
        do {
            let token = try StorageManager.shared.getAuthToken() ?? ""
            let response = try await repository.getTripHistory(token: token, page: "1")
            if response.isSuccess, let data = response.data {
                print(data)
            } else {
                errorMessage = response.message
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    

}
