//
//  WeatherRepository.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.10.2025.
//

import SwiftData
import Foundation

class WeatherRepository {
    let context : ModelContext
    
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save() throws { try context.save() }
    
   
    func fetchAllCities() throws -> [WeatherData] {
        let descriptor = FetchDescriptor<WeatherData>( sortBy: [SortDescriptor(\.city)] )
        return try self.context.fetch(descriptor)
    }
    
    
    func createCity(from apiData: APIWeatherData, coordinate: GeocodeResult) async -> WeatherData {
        let weatherDataToSave = WeatherData.fromAPI(apiData: apiData, coordinate: coordinate )
        self.context.insert(weatherDataToSave)
        
        print("✅ (\(coordinate.name)) inserted into context.")
        
        return weatherDataToSave
    }
    
    func update(existingCity: WeatherData, with apiData: APIWeatherData) {
        
        applyAPIData(to: existingCity, from: apiData)
        
        print("🔄 \(existingCity.city) data updated in context.")
    }
    

    func delete(city: WeatherData)  {
        
        self.context.delete(city)
        
        print("✅ City \(city.city) successfully deleted.")
    }
    
    
    private func applyAPIData(to weatherData: WeatherData, from apiData: APIWeatherData) {
        weatherData.timeZoneIdentifier = apiData.timeZone
        
        if let current = weatherData.current {
            current.weatherCode = apiData.current.weatherCode
            current.temperature = apiData.current.temperature
            current.rain = apiData.current.rain
            current.showers = apiData.current.showers
            current.windSpeed = apiData.current.windSpeed
            current.snowfall = apiData.current.snowfall
            current.windDirection = apiData.current.windDirection
        }
       
        weatherData.hourly.removeAll()
        
        let newHourly: [Hourly] = (0..<apiData.hourly.time.count).compactMap { i in
            let timeString = apiData.hourly.time[i]
            guard let forecastDate = WeatherFormatter.inputHourFormatter.date(from: timeString) else { return nil }
           
            let hour = Hourly(weatherCode: apiData.hourly.weatherCode[i],
                              date: forecastDate,
                              temperature: apiData.hourly.temperature[i],
                              showers: apiData.hourly.showers[i],
                              snowfall: apiData.hourly.snowfall[i],
                              windSpeed: apiData.hourly.windSpeed[i],
                              rain: apiData.hourly.rain[i])
            
            hour.weatherData = weatherData
            return hour
        }
        
        weatherData.hourly = newHourly
        
        weatherData.daily.removeAll()
        
        let newDaily: [Daily] = (0..<apiData.daily.time.count).compactMap { i in
            let timeString = apiData.daily.time[i]
            guard let forecastDate = WeatherFormatter.inputDateFormatter.date(from: timeString) else {
                return nil
            }
            let day = Daily(weatherCode: apiData.daily.weatherCode[i],
                            date: forecastDate,
                            temperatureMax: apiData.daily.temperatureMax[i],
                            temperatureMin: apiData.daily.temperatureMin[i])
          
            day.weatherData = weatherData
            return day
        }
       weatherData.daily = newDaily
    }
}



