//
//  TripViewModel.swift
//  
//
//  Created by Tejas on 03/10/25.
//

//
//final class TripViewModel: ObservableObject {
//    @Published var trips: [TripDetail] = []
//    @Published var errorMessage: String?
//    @Published var isLoading = false
//    
//    private let repository: TripRepository
//    
//    init(repository: TripRepository = AppDependencies.shared.makeTripRepository()) {
//        self.repository = repository
//    }
//    
//    func createTrip(token: String) async {
//        isLoading = true
//        errorMessage = nil
//        do {
//            let request = CreateTripRequest(
//                token: token,
//                link: "trip_123",
//                startLat: "40.7128",
//                startLong: "-74.0060",
//                startLocation: "123 Main St",
//                endLat: "40.7589",
//                endLong: "-73.9851",
//                endLocation: "456 Broadway",
//                estimateDistance: "5.2",
//                itemId: "[{\"id\":1,\"name\":\"Package\",\"price\":10}]"
//            )
//            
//            let response = try await repository.createTrip(request)
//            if response.status != "SUCCESS" {
//                errorMessage = response.message
//            }
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//        isLoading = false
//    }
//    
//    func loadMyTrips(token: String) async {
//        isLoading = true
//        errorMessage = nil
//        do {
//            let response = try await repository.showMyRequests(token: token, driver: "0")
//            if response.status == "SUCCESS", let data = response.data {
//                trips = data
//            } else {
//                errorMessage = response.message
//            }
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//        isLoading = false
//    }
//}
