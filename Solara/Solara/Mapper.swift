//
//  Mapper.swift
//  Solara
//
//  Created by Zeynep Cankaya on 25.10.2025.
//

import SwiftData
import Foundation

struct Mapper {
    
    let hourlyDateParser : DateParsing
    let dailyDateParser : DateParsing
    
    init(hourlyDateParser : DateParsing =  WeatherFormatter.inputHourFormatter,
         dailyDateParser : DateParsing = WeatherFormatter.inputDateFormatter) {
        
        self.hourlyDateParser = hourlyDateParser
        self.dailyDateParser = dailyDateParser
    }
    
    func update(existingData: WeatherData, with apiData : APIWeatherData) {
       
        existingData.timeZoneIdentifier = apiData.timeZone
        existingData.current = mapCurrent(from: apiData.current, context: existingData.modelContext)
        existingData.hourly = mapHourly(from: apiData.hourly,context: existingData.modelContext)
        existingData.daily = mapDaily(from: apiData.daily, context: existingData.modelContext)
        
        print("✅ Mapper: \(existingData.city) updated.")
    }
    
    func map(apiData: APIWeatherData, coordinate: GeocodeResult, context: ModelContext? = nil) -> WeatherData {

                let current = mapCurrent(from: apiData.current, context: context)
                let hourly = mapHourly(from: apiData.hourly, context: context)
                let daily = mapDaily(from: apiData.daily, context: context)
             
                
                return WeatherData(
                    city: coordinate.name,
                    admin1: coordinate.admin1,
                    latitude : coordinate.latitude,
                    longitude: coordinate.longitude,
                    timeZoneIdentifier: apiData.timeZone,
                    current: current,
                    hourly: hourly,
                    daily: daily)
            }
    private func mapCurrent(from apiCurrent: APICurrent, context : ModelContext?) -> Current {
        
            return Current(
                weatherCode: apiCurrent.weatherCode,
                temperature: apiCurrent.temperature,
                rain: apiCurrent.rain,
                showers: apiCurrent.showers,
                windSpeed: apiCurrent.windSpeed,
                snowfall: apiCurrent.snowfall,
                windDirection: apiCurrent.windDirection
            )
        }
    private func mapHourly(from apiHourly: APIHourly, context : ModelContext?) -> [Hourly] {
            return apiHourly.time.indices.compactMap { index -> Hourly? in
                let timeString = apiHourly.time[index]
                guard let date = hourlyDateParser.date(from: timeString) else { return nil }
                
                return Hourly(
                    weatherCode: apiHourly.weatherCode[index],
                    date: date,
                    temperature: apiHourly.temperature[index],
                    showers: apiHourly.showers[index],
                    snowfall : apiHourly.snowfall[index],
                    windSpeed: apiHourly.windSpeed[index],
                    rain: apiHourly.rain[index]
                )
            }
        }
    
    private func mapDaily(from apiDaily: APIDaily, context : ModelContext?) -> [Daily] {
            return apiDaily.time.indices.compactMap { index -> Daily? in
                let timeString = apiDaily.time[index]
                guard let date = dailyDateParser.date(from: timeString) else { return nil }
                
                return Daily(
                    weatherCode: apiDaily.weatherCode[index],
                    date: date,
                    temperatureMax: apiDaily.temperatureMax[index],
                    temperatureMin: apiDaily.temperatureMin[index]
                )
            }
        }
}
