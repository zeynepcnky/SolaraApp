//
//  WeatherData.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import Foundation

struct WeatherData : Decodable {
    let latitude : Double
    let longitude : Double
    let timezone : String
    let timeZoneAbbreviation : String
    let utcOffset : Int
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    enum CodingKeys  :String, CodingKey {
        case latitude, longitude, timezone
        case timeZoneAbbreviation = "timezone_abbreviation"
        case utcOffset = "utc_offset_seconds"
        case current = "current_weather"
        case hourly, daily
    }
    
}
struct Current : Decodable {
        let time : String
        let temperature: Float
        let isDay: Float
        let rain: Float
        let showers: Float
        let windSpeed: Float
        let snowfall: Float
        let windDirection : Float
        
        enum CodingKeys : String, CodingKey {
        
            case temperature = "temperature_2m"
            case isDay = "is_Day"
            case rain, showers, snowfall, time
            case windSpeed = "wind_speed"
            case windDirection = "wind_direction"
        }
    }
    
struct Hourly : Decodable {
        let time: [String]
        let temperature: [Float]
        let rain: [Float]
        let isDay: [Float]
    
    
    enum CodingKeys : String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case rain
        case isDay = "is_Day"
    }
}
    
struct Daily : Decodable {
        let time: [String]
        let temperatureMax: [Float]
        let temperatureMin: [Float]
    
    enum CodingKeys : String, CodingKey {
        case time
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}
    

