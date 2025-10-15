//
//  File.swift
//  Solara
//
//  Created by Zeynep Cankaya on 21.08.2025.
//

import SwiftData

struct APIWeatherData: Decodable {
    
    let timeZone : String
    let timeZoneAbbreviation : String
    let current: APICurrent
    let hourly: APIHourly
    let daily: APIDaily
    
    enum CodingKeys: String, CodingKey{
        case timeZone = "timezone"
        case timeZoneAbbreviation = "timezone_abbreviation"
        case current
        case hourly
        case daily
    }
}

struct APICurrent: Decodable {
    
    let weatherCode: Int
    let temperature: Double
    let rain: Float
    let showers: Float
    let windSpeed: Float
    let snowfall: Float
    let windDirection: Float
    
    enum CodingKeys: String, CodingKey {
        case weatherCode = "weather_code"
        case temperature = "temperature_2m"
        case rain
        case showers
        case windSpeed = "wind_speed_10m"
        case snowfall
        case windDirection = "wind_direction_10m"
    }
}

struct APIHourly: Decodable {
    let weatherCode: [Int]
    let time: [String]
    let temperature: [Double]
    let showers: [Float]
    let snowfall: [Float]
    let windSpeed: [Float]
    let rain: [Float]
    
    enum CodingKeys: String, CodingKey {
        case weatherCode = "weather_code"
        case time
        case temperature = "temperature_2m"
        case showers
        case snowfall
        case windSpeed = "wind_speed_10m"
        case rain
    }
}

struct APIDaily: Decodable {
    let weatherCode: [Int]
    let time: [String]
    let temperatureMax: [Double]
    let temperatureMin: [Double]
    
    enum CodingKeys : String, CodingKey {
        case weatherCode = "weather_code"
        case time
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
    }
}



    
