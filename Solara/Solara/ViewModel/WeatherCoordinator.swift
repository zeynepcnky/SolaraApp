//
//  WeatherCoordinator.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation
import SwiftData


@MainActor
final class WeatherCoordinator: ObservableObject {
    @Published var cityName : String = ""
    @Published var isSearchableActive : Bool = false
    @Published var addedCity : [WeatherData] = []
    @Published var isSheetActive : Bool = false
    @Published var selectedWeather : WeatherData?
    @Published var latitude : Double = 0.0
    @Published var longitude : Double = 0.0
    @Published var isLocationActive : Bool = false
    
    private let locationViewModel = LocationViewModel()
    let viewModel = WeatherViewModel()
    private var repository : WeatherRepository?
    
    
    
    
    func setupContext(_ context: ModelContext){
        self.repository = WeatherRepository(context: context)
    }
    
    func loadSavedCities(){
        guard let repository = self.repository else { return }
        
        do{
            self.addedCity = try repository.fetchAllCities()
            print("✅ \(self.addedCity.count) şehir Swift Data'dan yüklendi.")
        }catch{
            print("❌ Şehirler yüklenirken hata oluştu: \(error.localizedDescription)")
        }
    }
    
    func addCity() {
        guard let weather = viewModel.weather else  { return }
        if addedCity.contains(where: {$0.city == cityName}) { return }
        
        repository?.saveWeatherData(city: cityName, apiData: weather)
        
        loadSavedCities( )
    }

    func fetchCurrentLocation() {
        Task {
            await locationViewModel.getLocationWeather(lat: latitude, lon: longitude)
            isLocationActive = true
        }
        isLocationActive = false
    }
    
    func startSearch() {
        Task {
            await viewModel.getWeather(cityName: cityName)
            isSheetActive = true
        }
        isSearchableActive = false
        
    }
    
    func select(_ city: WeatherData) {
        selectedWeather = city
    }
    
    func confirmSelected() {
        selectedWeather = nil
    }
    
    func deleteCity(at offsets: IndexSet) {
            for index in offsets {
            let city = addedCity[index]
           }
        addedCity.remove(atOffsets: offsets)
    }
    
    func moveCity(from source : IndexSet, to destination: Int) {
        addedCity.move(fromOffsets: source, toOffset: destination)
    }
}

    

