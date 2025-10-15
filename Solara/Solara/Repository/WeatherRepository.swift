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
    
    func mapAPIDatatoWeatherData( apiData: APIWeatherData, city: String) -> WeatherData {
      let current = Current(weatherCode: apiData.current.weatherCode
                              , temperature: apiData.current.temperature
                              , rain: apiData.current.rain
                              , showers: apiData.current.showers
                              , windSpeed: apiData.current.windSpeed
                              , snowfall: apiData.current.snowfall
                              , windDirection: apiData.current.windDirection
        )
        
        let hourly : [Hourly] = (0..<apiData.hourly.time.count).compactMap { i in
            let timeString = apiData.hourly.time[i]
            guard let forecastDate = WeatherFormatter.inputHourFormatter.date(from: timeString) else {
                return nil
            }
           return Hourly(
                weatherCode: apiData.hourly.weatherCode[i],
                date: forecastDate,
                temperature: apiData.hourly.temperature[i],
                showers: apiData.hourly.showers[i],
                snowfall: apiData.hourly.snowfall[i],
                windSpeed: apiData.hourly.windSpeed[i],
                rain: apiData.hourly.rain[i])
        }
        
        let daily : [Daily] = (0..<apiData.daily.time.count).compactMap { i in
            let timeString = apiData.daily.time[i]
            
            guard let forecastDate = WeatherFormatter.inputDateFormatter.date(from: timeString)else {
                return nil
            }
            
           return Daily(weatherCode: apiData.daily.weatherCode[i],
                  date: forecastDate,
                  temperatureMax: apiData.daily.temperatureMax[i],
                  temperatureMin: apiData.daily.temperatureMin[i])
        }
        
        let weatherData = WeatherData(city: city, timeZoneIdentifier: apiData.timeZone, current: current, hourly: hourly, daily: daily)
        current.weatherData = weatherData
        hourly.forEach { $0.weatherData = weatherData}
        daily.forEach { $0.weatherData = weatherData}
        
        return weatherData
    }
    
  func fetchAllCities() throws -> [WeatherData] {
        let descriptor = FetchDescriptor<WeatherData>(
            sortBy: [SortDescriptor(\WeatherData.city)]
        )
        return try self.context.fetch(descriptor)
    }
    
    func createAndSaveCity(from apiData: APIWeatherData, cityName: String) async -> WeatherData? {
        
        let weatherDataToSave = self.mapAPIDatatoWeatherData(apiData: apiData, city: cityName)
        
        do {
         
            self.context.insert(weatherDataToSave)
           
            try self.context.save()
            print("✅ City data (\(cityName)) successfully saved.")
            return weatherDataToSave
        } catch {
            print("❌ Save error: \(error)")
           
            return nil
        }
    }
    
    func delete(city: WeatherData) throws {
        do {
            self.context.delete(city)
            
            try self.context.save()
            print("✅ City \(city.city) successfully deleted.")
        }
        catch { print("❌ Error: Something went wrong while deleting city. \(error)")
        throw error
        }
    }
    
    func update(existingCity: WeatherData, with apiData: APIWeatherData) {
       
        existingCity.timeZoneIdentifier = apiData.timeZone
        
        if let current = existingCity.current {
            current.weatherCode = apiData.current.weatherCode
            current.temperature = apiData.current.temperature
            current.rain = apiData.current.rain
            current.showers = apiData.current.showers
            current.windSpeed = apiData.current.windSpeed
            current.snowfall = apiData.current.snowfall
            current.windDirection = apiData.current.windDirection
        }
        
        existingCity.hourly.removeAll()
        
        
        let newHourly: [Hourly] = (0..<apiData.hourly.time.count).compactMap { i in
            let timeString = apiData.hourly.time[i]
                      guard let forecastDate = WeatherFormatter.inputHourFormatter.date(from: timeString) else {
                          return nil
                      }
            let hour = Hourly(weatherCode: apiData.hourly.weatherCode[i], date: forecastDate, temperature: apiData.hourly.temperature[i], showers: apiData.hourly.showers[i], snowfall: apiData.hourly.snowfall[i], windSpeed: apiData.hourly.windSpeed[i], rain: apiData.hourly.rain[i])
                   hour.weatherData = existingCity
                   return hour
               }
        existingCity.hourly = newHourly
        
        existingCity.daily.removeAll()
       
        let newDaily: [Daily] = (0..<apiData.daily.time.count).compactMap { i in
            let timeString = apiData.daily.time[i]
            guard let forecastDate = WeatherFormatter.inputDateFormatter.date(from: timeString) else {
                return nil
            }
                    let day = Daily(weatherCode: apiData.daily.weatherCode[i], date: forecastDate, temperatureMax: apiData.daily.temperatureMax[i], temperatureMin: apiData.daily.temperatureMin[i])
                    day.weatherData = existingCity
                    return day
                }
        existingCity.daily = newDaily
        
        print("🔄 \(existingCity.city) data updated.")
    }
}



