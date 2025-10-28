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
    
    let geocodeService : GeoServiceProtocol
   
    init(geocodeService : GeoServiceProtocol) {
        self.geocodeService = geocodeService
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
                
                self.isSearching = true
                
                return Future<[GeocodeResult], Error> { promise in
                    Task {
                        do {
                            let results = try await self.geocodeService.getGeoData(cityName: searchText)
                           
                            promise(.success(results))
                        }
                        catch { promise(.failure(error)) }
                    }
                }
                .catch { error -> Just<[GeocodeResult]> in
                    print("❌ Arama sırasında GeoService hatası: \(error)")
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                    return Just([])
                }
                .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] results in
                
                self?.isSearching = false
                self?.searchCoordinate = results
            } .store(in: &cancellables)
    }
        
    func clearSearch() {
        searchText = ""
        searchCoordinate = []
        }
}
    
