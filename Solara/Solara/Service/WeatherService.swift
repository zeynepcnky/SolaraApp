//
//  WeatherService.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import Foundation

struct WeatherService  {
    
    static let shared = WeatherService()
    
  
    func fetchWeather(latitude:Double, longitude :Double) async throws -> WeatherData {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min&hourly=temperature_2m,rain,showers,snowfall,wind_speed_10m,is_day&models=best_match&current=temperature_2m,is_day,wind_speed_10m,wind_direction_10m,snowfall,showers,rain&forecast_days=14&timezone=GMT"
        
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data,_) = try await URLSession.shared.data(from: url)
       
        do {
            let decoder = try JSONDecoder().decode(WeatherData.self, from: data)
            //print(String(data: data, encoding: .utf8)!)
            return decoder
            
        } catch {
            print(" Weather Decode Error\(error)")
            throw error
        }
        
    }
    
}

