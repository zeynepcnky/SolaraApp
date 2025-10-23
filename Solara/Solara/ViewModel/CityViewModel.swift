//
//  CityViewModel.swift
//  Solara
//
//  Created by Zeynep Cankaya on 16.10.2025.
//

import Foundation

@MainActor
final class CityViewModel : ObservableObject {
    
    let cityData : WeatherData
    
    var cityName: String {cityData.city}
    
    var timeZoneIdentifier : String {cityData.timeZoneIdentifier}
    
    var headerIcon: WeatherIcon {
        WeatherIcon(code: cityData.current?.weatherCode ?? 0)
    }
    var currentTemperature: Double {
        cityData.current?.temperature ?? 0.0
    }
    var maxTemperature: Double {
        cityData.daily.first?.temperatureMax ?? 0.0
    }
    
    var minTemperature: Double {
        cityData.daily.first?.temperatureMin ?? 0.0
    }
    
    var dailyForecasts: [Daily] {
        cityData.daily.sorted { $0.date ?? Date() < $1.date ?? Date()}
    }
    
    var hourlyforecasts: [Hourly] {
        let now = Date()
        return cityData.hourly
            .filter { $0.date ?? Date() >= now}
            .sorted { $0.date ?? Date() < $1.date ?? Date()}
            }
        
        init(cityData: WeatherData) {
        self.cityData = cityData
    }
}

