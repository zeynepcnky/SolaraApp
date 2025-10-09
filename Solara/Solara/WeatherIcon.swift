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
    
    var gradient: LinearGradient {
            switch self {
            case .clearDay:
                return LinearGradient(colors: [.lightYellow, .babyOrange],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            case .partlyCloudy:
                return LinearGradient(colors: [.baby, .darkBlue],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            case .fog:
                return LinearGradient(colors: [.gray.opacity(0.8), .black.opacity(0.5)],
                                      startPoint: .top,
                                      endPoint: .bottom)
            case .rain, .rainShowers:
                return LinearGradient(colors: [.blue, .indigo],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            case .snow, .snowShowers, .snowGrains:
                return LinearGradient(colors: [.white, .blue.opacity(0.5)],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            case .thunderstorm, .thunderstormHail:
                return LinearGradient(colors: [.purple, .black],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            default:
                return LinearGradient(colors: [.blue, .purple],
                                      startPoint: .topLeading,
                                      endPoint: .bottomTrailing)
            }
        }
    var cardGradient: LinearGradient {
         LinearGradient(colors: [.white.opacity(0.3), .white.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
     }
    }

