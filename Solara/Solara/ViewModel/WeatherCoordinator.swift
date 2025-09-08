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
    @Published var addedCity : [WeatherItem] = []
    @Published var isSheetActive : Bool = false
    @Published var selectedWeather : WeatherItem? = nil
    
    let viewModel = WeatherViewModel()
    
    func startSearch() {
        Task {
            await viewModel.getWeather(cityName: cityName)
            isSheetActive = true
        }
        isSearchableActive = false
        
    }
    func select(_ city: WeatherItem) {
        selectedWeather = city
    }
    
    func confirmSelected() {
        selectedWeather = nil
        }
    func addCity() {
        if let weather = viewModel.weather {
            let newItem = WeatherItem(city: cityName, temp: weather)
            
            if !addedCity.contains(where: { $0.city == cityName }) {
                addedCity.append(newItem)
            }
        }
    }
    
    func deleteAll() {
        addedCity.removeAll()
    }
}

    

