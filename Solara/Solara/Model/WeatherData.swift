//
//  WeatherData.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import Foundation

struct WeatherData : Decodable {
    
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    enum CodingKeys : String, CodingKey {
        case hourly, daily, current
    }
    
}
struct Current : Decodable {
        
        let temperature: Double
        let isDay: Float
        let rain: Float
        let showers: Float
        let windSpeed: Float
        let snowfall: Float
        let windDirection : Float
        
        enum CodingKeys : String, CodingKey {
        
            case temperature = "temperature_2m"
            case isDay = "is_day"
            case rain, showers, snowfall
            case windSpeed = "wind_speed_10m"
            case windDirection = "wind_direction_10m"
        }
    }
    
struct Hourly : Decodable {
     
        let temperature: [Double]
        let showers: [Float]
        let snowfall: [Float]
        let windSpeed : [Float]
        let rain: [Float]
        let isDay: [Float]
    
    
    enum CodingKeys : String, CodingKey {
       
        case windSpeed = "wind_speed_10m"
        case temperature = "temperature_2m"
        case rain, showers, snowfall
        case isDay = "is_day"
    }
}
    
struct Daily : Decodable {
       
        let temperatureMax: [Double]
        let temperatureMin: [Double]
    
    enum CodingKeys : String, CodingKey {
       
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}
    

