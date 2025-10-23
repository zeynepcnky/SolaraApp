//
//  WeatherData.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//
import Foundation
import SwiftData
@Model
final class WeatherData : Identifiable {
    
  
    var city: String
    var timeZoneIdentifier : String = "GMT"
    
    
    @Relationship(deleteRule: .cascade)
    var current: Current?
    
    @Relationship(deleteRule: .cascade)
    var hourly: [Hourly] = []
    
    @Relationship(deleteRule: .cascade)
    var daily: [Daily] = []
    
    init(city: String, timeZoneIdentifier: String, current: Current? = nil, hourly: [Hourly]=[], daily: [Daily]=[]) {
        self.city = city
        self.timeZoneIdentifier = timeZoneIdentifier
        self.current = current
        self.hourly = hourly
        self.daily = daily
    }
}
@Model
class Current {
       
        var weatherCode: Int
        var temperature: Double
        var rain: Float
        var showers: Float
        var windSpeed: Float
        var snowfall: Float
        var windDirection : Float
    
    var weatherData : WeatherData?
        
    init(  weatherCode: Int, temperature: Double, rain: Float, showers: Float, windSpeed: Float, snowfall: Float, windDirection: Float) {
       
        self.weatherCode = weatherCode
        self.temperature = temperature
        self.rain = rain
        self.showers = showers
        self.windSpeed = windSpeed
        self.snowfall = snowfall
        self.windDirection = windDirection
    }
}
 @Model
class Hourly  {
        var weatherCode: Int
        var date : Date?
        var temperature: Double
        var showers: Float
        var snowfall: Float
        var windSpeed : Float
        var rain: Float
      
    var weatherData : WeatherData?
    
    init(weatherCode: Int, date: Date, temperature: Double, showers: Float, snowfall: Float, windSpeed: Float, rain: Float) {
        self.weatherCode = weatherCode
        self.date = date
        self.temperature = temperature
        self.showers = showers
        self.snowfall = snowfall
        self.windSpeed = windSpeed
        self.rain = rain

    }
}
@Model
class Daily  {
    var weatherCode: Int
    var date : Date?
    var temperatureMax: Double
    var temperatureMin: Double
   
    var weatherData : WeatherData?
    
    init(weatherCode: Int, date : Date, temperatureMax: Double, temperatureMin: Double) {
        self.weatherCode = weatherCode
        self.date = date
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
    }
}
extension WeatherData {
    static func fromAPI(apiData: APIWeatherData, coordinate: GeocodeResult) -> WeatherData {
        let current = Current(weatherCode: apiData.current.weatherCode,
                              temperature: apiData.current.temperature,
                              rain: apiData.current.rain,
                              showers: apiData.current.showers,
                              windSpeed: apiData.current.windSpeed,
                              snowfall: apiData.current.snowfall,
                              windDirection: apiData.current.windDirection)
       
        let hourly = apiData.hourly.time.indices.compactMap { index -> Hourly? in
            let timeStrig = apiData.hourly.time[index]
            guard let date = WeatherFormatter.inputHourFormatter.date(from: timeStrig) else { return nil }
           return Hourly(
                    weatherCode: apiData.hourly.weatherCode[index],
                    date: date,
                   temperature: apiData.hourly.temperature[index],
                    showers: apiData.hourly.showers[index],
                    snowfall : apiData.hourly.snowfall[index],
                   windSpeed: apiData.hourly.windSpeed[index],
                    rain: apiData.hourly.rain[index],
            
            )
        }
        let daily = apiData.daily.time.indices.compactMap { index -> Daily? in
            let timeString = apiData.daily.time[index]
            guard let date = WeatherFormatter.inputDateFormatter.date(from: timeString) else { return nil }
          return Daily(
                weatherCode: apiData.daily.weatherCode[index],
                date: date,
                temperatureMax: apiData.daily.temperatureMax[index],
                temperatureMin: apiData.daily.temperatureMin[index] )
        }
        
        return WeatherData(
            city: coordinate.name,
            timeZoneIdentifier: apiData.timeZone,
            current: current,
            hourly: hourly,
            daily: daily
        )
    }
}
    

