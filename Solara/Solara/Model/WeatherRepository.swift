//
//  WeatherRepository.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.10.2025.
//

import SwiftData

class WeatherRepository {
    private let context : ModelContext
    
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveWeatherData (city: String, apiData: APIWeatherData) {
        let current = Current(weatherCode: apiData.current.weatherCode ,
                              temperature: apiData.current.temperature, isDay: <#Float#>,
                            
                              rain: apiData.current.rain,
                              showers: apiData.current.showers,
                              windSpeed: apiData.current.windSpeed,
                              snowfall: apiData.current.snowfall,
                              windDirection: apiData.current.windDirection)
        
        let hourly = [
            Hourly(
                weatherCode: apiData.hourly.weatherCode,
                time: apiData.hourly.time,
                temperature: apiData.hourly.temperature,
                showers: apiData.hourly.showers,
                snowfall: apiData.hourly.snowfall,
                windSpeed: apiData.hourly.windSpeed,
                rain: apiData.hourly.rain, isDay: <#[Float]#>,
         
                   
                   )
            ]
        
          
        
        let daily = [
            Daily(
                weatherCode: apiData.daily.weatherCode,
                time: apiData.daily.time,
                temperatureMax: apiData.daily.temperatureMax,
                temperatureMin: apiData.daily.temperatureMin
                )
            ]
        
        let weatherData = WeatherData(city: city, current: current, hourly: hourly, daily: daily)
        
        context.insert(weatherData)
        try? context.save()
        }
    }



