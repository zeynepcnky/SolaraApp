//
//  WeatherViewModel.swift
//  Solara
//
//  Created by Zeynep Cankaya on 20.07.2025.
//

import Foundation
import Combine

@MainActor
class WeatherSearchViewModel : ObservableObject {
   
    @Published var searchText: String = ""
   
    @Published var searchCoordinate: [GeocodeResult] = []
    
    @Published var isSearching: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
   private let geocodeService = GeoService()
   
    init() {
            setupSearchTextSubscriber()
        }
    
        private func setupSearchTextSubscriber() {
            $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .filter { $0.count >= 3 }
            .removeDuplicates()
            .flatMap { [weak self] (searchText) -> AnyPublisher<[GeocodeResult], Never> in
                            guard let self = self else {
                            return Just([]).eraseToAnyPublisher()
                            }
                return Future<[GeocodeResult], Error> { promise in
                Task {
                    do {
                        let results = try await self.geocodeService.getGeoData(cityName: searchText)
                        let filteredResults = self.filterResultsByPrimaryRegion(results)
                        promise(.success(filteredResults))
                        }
                    catch { promise(.failure(error)) }
                }
            }
                .catch { error -> Just<[GeocodeResult]> in
                    print("❌ Arama sırasında GeoService hatası: \(error.localizedDescription)")
                    return Just([])
                    }
                    .eraseToAnyPublisher()
                }
                    .receive(on: RunLoop.main)
                    .assign(to: &$searchCoordinate)
            }
    
     
    
        private func filterResultsByPrimaryRegion(_ results: [GeocodeResult]) -> [GeocodeResult] {
            guard let primaryResult = results.first else {
                return []
            }
            let primaryAdmin = primaryResult.admin1
            let primaryCountry = primaryResult.country
        
            let filteredList = results.filter { result in
            guard result.country == primaryCountry, primaryCountry != nil else {
                return false
            }
            if let primaryAdmin = primaryAdmin {
                return result.admin1 == primaryAdmin
            }
            return true
        }
            return filteredList
    }
    
    func clearSearch() {
        searchText = ""
        searchCoordinate = []
        }
}
    
