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
    var latitude : Double
    var longitude : Double
    
    var admin1 : String?
    var timeZoneIdentifier : String = "GMT"
    
    
    var current: Current?
   
    var hourly: [Hourly] = []
    
    var daily: [Daily] = []
    
    init(city: String, admin1 : String?, latitude: Double, longitude : Double, timeZoneIdentifier: String, current: Current? = nil, hourly: [Hourly]=[], daily: [Daily]=[]) {
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.admin1 = admin1
        self.timeZoneIdentifier = timeZoneIdentifier
        self.current = current
        self.hourly = hourly
        self.daily = daily
        
      
    }
}

@Model
class Current  {
       
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
class Hourly {
        var weatherCode: Int
        var date : Date?
        var temperature: Double
        var showers: Float
        var snowfall: Float
        var windSpeed : Float
        var rain: Float
      
    var id: Date? { date }

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
class Daily {
    var weatherCode: Int
    var date : Date?
    var temperatureMax: Double
    var temperatureMin: Double
 
    var id: Date? { date }
    var weatherData : WeatherData?
    
    init(weatherCode: Int, date : Date, temperatureMax: Double, temperatureMin: Double) {
        self.weatherCode = weatherCode
        self.date = date
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
  
    }
}

    

