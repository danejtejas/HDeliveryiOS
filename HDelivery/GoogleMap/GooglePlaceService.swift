//
//  GooglePlaceService.swift
//  HDelivery
//
//  Created by Tejas on 01/10/25.
//

import Foundation
import GooglePlaces
import Combine


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
}



