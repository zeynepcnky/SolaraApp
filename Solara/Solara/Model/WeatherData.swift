//
//  WeatherData.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftData
@Model
class WeatherData {
  
    var city: String
    
    @Relationship(deleteRule: .cascade)
    var current: Current
    
    @Relationship(deleteRule: .cascade)
    var hourly: [Hourly] = []
    
    @Relationship(deleteRule: .cascade)
    var daily: [Daily] = []
    
   init(city: String, current: Current, hourly: [Hourly]=[], daily: [Daily]=[]) {
        self.city = city
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
        
    init(weatherCode: Int, temperature: Double, rain: Float, showers: Float, windSpeed: Float, snowfall: Float, windDirection: Float) {
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
        var time: String
        var temperature: Double
        var showers: Float
        var snowfall: Float
        var windSpeed : Float
        var rain: Float
      
    var weatherData : WeatherData?
    
    init(weatherCode: Int, time: String, temperature: Double, showers: Float, snowfall: Float, windSpeed: Float, rain: Float) {
        self.weatherCode = weatherCode
        self.time = time
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
    var time : String
    var temperatureMax: Double
    var temperatureMin: Double
   
    var weatherData : WeatherData?
    
    init(weatherCode: Int, time: String, temperatureMax: Double, temperatureMin: Double) {
        self.weatherCode = weatherCode
        self.time = time
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
    }
}

    

