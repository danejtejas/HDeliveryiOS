//
//  GooglePlaceService.swift
//  HDelivery
//
//  Created by Tejas on 01/10/25.
//

import Foundation
import GooglePlaces
import Combine
import CoreLocation


class GooglePlaceService: ObservableObject {
    private var placesClient = GMSPlacesClient.shared()
    private var cancellables = Set<AnyCancellable>()

    @Published var query: String = ""
    @Published var predictions: [GMSAutocompletePrediction] = []

    init() {
        $query
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.predictions = []
                } else {
                    self.fetchPredictions(for: text)
                }
            }
            .store(in: &cancellables)
    }

    private func fetchPredictions(for query: String) {
        let filter = GMSAutocompleteFilter()
//        filter.type = .noFilter

        placesClient.findAutocompletePredictions(fromQuery: query,
                                                 filter: filter,
                                                 sessionToken: nil) { results, error in
            if let error = error {
                print("Places API error: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.predictions = results ?? []
            }
        }
    }

    func fetchPlaceDetails(placeID: String, completion: @escaping (Result<(name: String?, coordinate: CLLocationCoordinate2D), Error>) -> Void) {
        let fields: GMSPlaceField = [.name, .placeID, .coordinate]
        placesClient.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil) { place, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let place = place else {
                completion(.failure(NSError(domain: "GooglePlaceService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Place not found"])) )
                return
            }
            completion(.success((name: place.name, coordinate: place.coordinate)))
        }
    }
    
    // MARK: - Get Place ID using Google Places SDK form current location
//     func getPlaceID(completion: @escaping (Result<(name: String?, coordinate: CLLocationCoordinate2D), Error>) -> Void) {
//        guard  let coordinate  = LocationManager.shared.currentLocation?.coordinate else {
//            print("not able to get current location")
//            return
//        }
//        let placesClient = GMSPlacesClient.shared()
////         _ = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        let fields: GMSPlaceField = [.placeID, .name, .coordinate]
//        
//        
//        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields) { likelihoods, error in
//            if let error = error {
//                print("❌ Failed to get place: \(error.localizedDescription)")
//                return
//            }
//            
//            if let place = likelihoods?.first?.place {
//                completion(.success((name: place.name, coordinate: place.coordinate)))
//            } else {
//                completion(.failure(NSError(domain: "GooglePlaceService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Place not found"])) )
//            }
//        }
//    }
}






