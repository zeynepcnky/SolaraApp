//
//  WeatherViewModel.swift
//  Solara
//
//  Created by Zeynep Cankaya on 20.07.2025.
//

import Foundation
@MainActor
// UI changes uptaded on MAİN THREAD
class WeatherViewModel : ObservableObject {
    
    @Published var weather: WeatherData?
    @Published var coordinate:  GeocodeResult?
    
    private let weatherService =  WeatherService()
    private let geocodeService = GeoService()
    
    func getWeather(cityName: String) async{
        do{
            
            guard let coords = try await geocodeService.getGeoData(cityName: cityName) else {
                print("City not found")
                return
            }
            self.coordinate = coords
        
            let data = try await weatherService.fetchWeather(latitude: coords.latitude, longitude: coords.longitude  )
            self.weather = data
            
        } catch {
            print(error)
        }
        
    }
    
}
    
