//
//  WeatherIcon.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.09.2025.
//
import SwiftUI

enum WeatherIcon{
    case clearDay
    case partlyCloudy
    case fog
    case drizzle
    case freezingDrizzle
    case rain
    case freezingRain
    case snow
    case snowGrains
    case rainShowers
    case snowShowers
    case thunderstorm
    case thunderstormHail
    case unknown
    
    init(code: Int) {
        switch code{
        case 0 : self = .clearDay
        case 1...3 : self = .partlyCloudy
        case 45, 48 : self = .fog
        case 51, 53, 55 : self = .drizzle
        case 56, 57 : self = .freezingDrizzle
        case 61, 63, 65 : self = .rain
        case 66, 67 : self = .freezingRain
        case 71, 73, 75 : self = .snow
        case 77 : self = .snowGrains
        case 80, 81, 82 : self = .rainShowers
        case 85, 86 : self = .snowShowers
        case 95 : self = .thunderstorm
        case 96, 99 :  self  = .thunderstormHail
        default : self = .unknown
        }
    }
    var assetName: String {
        switch self {
        case .clearDay: return "Sun"
        case .partlyCloudy: return "Cloudy"
        case .fog: return "Fog"
        case .drizzle: return "Drizzle"
        case .freezingDrizzle: return "FreezingDrizzle"
        case .rain: return "Rain"
        case .freezingRain: return "FreezingRain"
        case .snow: return "Snow"
        case .snowGrains: return "SnowGrains"
        case .rainShowers: return "RainShowers"
        case .snowShowers: return "SnowShowers"
        case .thunderstorm: return "Thunderstorm"
        case .thunderstormHail: return "ThunderstormHail"
        case .unknown: return "Image"
        }
    }
    
    var description: String {
        switch self {
        case .clearDay:
            return "Clear Sky"
        case .partlyCloudy:
            return "Mostly Cloudy"
        case .fog:
            return "Fog and Rime Fog"
        case .drizzle:
            return "Drizzle"
        case .freezingDrizzle:
            return "Freezing Drizzle"
        case .rain:
            return "Rain"
        case .freezingRain:
            return "Freezing Rain"
        case .snow:
            return "Snowfall"
        case .snowGrains:
            return "Snow Grains"
        case .rainShowers:
            return "Rain Showers"
        case .snowShowers:
            return "Snow Showers"
        case .thunderstorm:
            return "Thunderstorm"
        case .thunderstormHail:
            return "Thunderstorm with Hail"
        case .unknown:
            return "Weather information unavailable"
        }
    }
}

