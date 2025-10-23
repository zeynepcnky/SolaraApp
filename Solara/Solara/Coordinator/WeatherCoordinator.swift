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
        
  @ObservedObject var cityListViewModel = CityListViewModel()
  @ObservedObject var viewModel =  WeatherSearchViewModel()
    
    @Published var searchedCityDetail : WeatherData?
    @Published var selectedCityForDetail : WeatherData?

    private var isSearchActive : Binding<Bool>?
    private var lastGeocodeResult : GeocodeResult?
    private let service = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        cityListViewModel.objectWillChange.sink { [weak self]_ in
            self?.objectWillChange.send()
        }
        .store(in: &cancellables)
        }
    
    
    func setup(with context: ModelContext, isSearchActive: Binding<Bool>?){
        cityListViewModel.setupContext(context)
        self.isSearchActive = isSearchActive
    }
  

    func selectCityFromSearch(city : GeocodeResult) {
        self.lastGeocodeResult = city
        Task {
            do {
              let apiData = try await self.service.fetchWeather(latitude: city.latitude, longitude: city.longitude)
                let previewData = WeatherData.fromAPI(apiData: apiData, coordinate: city)
                self.searchedCityDetail = previewData
            }
            catch { print("❌ Error: Failed to fetch search details. - \(error)") }
        }
    }
    
    func addLastSearchedCity(){
        guard let cityToAdd = lastGeocodeResult else {
            print("❌ Error: Found no city to add.")
            return
        }
        Task {
            await cityListViewModel.fetchWeather(city: cityToAdd)
            
            self.searchedCityDetail = nil
            viewModel.clearSearch()
            self.isSearchActive?.wrappedValue = false
        }
    }
  }

    

