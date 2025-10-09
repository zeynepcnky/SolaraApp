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
                              temperature: apiData.current.temperature,
                              rain: apiData.current.rain,
                              showers: apiData.current.showers,
                              windSpeed: apiData.current.windSpeed,
                              snowfall: apiData.current.snowfall,
                              windDirection: apiData.current.windDirection)
        
        let hourly : [Hourly] = (0..<apiData.hourly.time.count).map{ i in
            
            Hourly(
                weatherCode: apiData.hourly.weatherCode[i],
                time: apiData.hourly.time[i],
                temperature: apiData.hourly.temperature[i],
                showers: apiData.hourly.showers[i],
                snowfall: apiData.hourly.snowfall[i],
                windSpeed: apiData.hourly.windSpeed[i],
                rain: apiData.hourly.rain[i],
                
                
            )
            
        }
        
        
        let daily : [Daily] = (0..<apiData.daily.time.count).map { i in
            Daily(
                weatherCode: apiData.daily.weatherCode[i],
                time: apiData.daily.time[i],
                temperatureMax: apiData.daily.temperatureMax[i],
                temperatureMin: apiData.daily.temperatureMin[i]
            )
        }
        
        
        
        
        let weatherData = WeatherData(city: city, current: current, hourly: hourly, daily: daily)
        current.weatherData = weatherData
        hourly.forEach { $0.weatherData = weatherData}
        daily.forEach { $0.weatherData = weatherData}
        
        do{
            self.context.insert(weatherData)
            
            try self.context.save()
            print("✅ Şehir verisi (\(city)) başarıyla kaydedildi.")
            
        } catch{
            print("❌ Kayıt hatası: \(error)")
        }
        
    }
    
    func fetchAllCities() throws -> [WeatherData] {
        let descriptor = FetchDescriptor<WeatherData>()
        return try self.context.fetch(descriptor)
    }
}



