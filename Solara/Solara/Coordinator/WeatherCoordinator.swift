//
//  WeatherCoordinator.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation
import SwiftUI
import SwiftData
import Combine

@MainActor
final class WeatherCoordinator: ObservableObject {
        
    var cityListViewModel : CityListViewModel
    var searchViewModel : WeatherSearchViewModel
    
    @Published var searchedCityDetail : WeatherData?
    @Published var selectedCityForDetail : WeatherData?

    
    private var lastGeocodeResult : GeocodeResult?
    private var cancellables = Set<AnyCancellable>()
    
    private let service : WeatherServiceProtocol
    private let mapper : Mapper
    
    init(cityListViewModel : CityListViewModel,
         searchViewModel : WeatherSearchViewModel,
         service: WeatherServiceProtocol,
         mapper : Mapper){
        
        self.cityListViewModel = cityListViewModel
        self.searchViewModel = searchViewModel
        self.service = service
        self.mapper = mapper
        
        cityListViewModel.objectWillChange.sink { [weak self]_ in
            self?.objectWillChange.send()
        }
            .store(in: &cancellables)
        
        searchViewModel.objectWillChange.sink { [weak self]_ in
                    self?.objectWillChange.send()
                }
                    .store(in: &cancellables)
            }
    
    

    func selectCityFromSearch(city : GeocodeResult) {
        self.lastGeocodeResult = city
        Task {
            do {
           
                let apiData = try await self.service.fetchWeather(latitude: city.latitude, longitude: city.longitude)
                
                let previewData = self.mapper.map(apiData: apiData, coordinate: city)
            
                self.searchedCityDetail = previewData
            }
            catch { print("❌ Error: Failed to fetch search details. - \(error)") }
        }
    }
    
    func addLastSearchedCity(isSearchedActive : Binding<Bool>){
        guard let cityToAdd = lastGeocodeResult else {
            print("❌ Error: Found no city to add.")
            return
        }
        Task {
            await cityListViewModel.fetchWeather(city: cityToAdd)
            
            self.searchedCityDetail = nil
            
            searchViewModel.clearSearch()
            
        }
    }
  }

    

