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
    
    private let weatherService =  WeatherService()
    
    
    func getWeather(latitude: Double, longitude: Double) async{
        
        do{
            let data = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            self.weather = data
            
        } catch {
            print(error)
        }
        
    }
    
}
    
