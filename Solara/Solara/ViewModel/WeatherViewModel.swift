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
    
    @Published var weather: APIWeatherData?
    @Published var coordinate:  GeocodeResult? = nil
    
    private let weatherService =  WeatherService()
    private let geocodeService = GeoService()
    
    func getWeather(cityName: String) async{
        do{
            
            guard let coords = try await geocodeService.getGeoData(cityName: cityName) else {
                print("City not found")
                return
            }
            self.coordinate = coords
            print("✅ Geo decode success → city: \(coords.name), lat: \(coords.latitude), lon: \(coords.longitude)")
        
            let data = try await weatherService.fetchWeather(latitude: coords.latitude, longitude: coords.longitude  )
            self.weather = data
            print("🌤 Weather fetched successfully for \(coords.name)")
                        print("   Current temp: \(data.current.temperature)")
                        print("   Max temp (today): \(data.daily.temperatureMax.first ?? 0)")
                        print("   Min temp (today): \(data.daily.temperatureMin.first ?? 0)")
                        print(" Weather Code: \(data.current.weatherCode)")
        } catch {
            print("❌ WeatherViewModel error: \(error)")
        }
        
    }
    
}
    
