//
//  File.swift
//  Solara
//
//  Created by Zeynep Cankaya on 21.08.2025.
//

import SwiftData

struct APIWeatherData: Decodable {
    let current: APICurrent
    let hourly: APIHourly
    let daily: APIDaily
}

struct APICurrent: Decodable {
    let weatherCode: Int
    let temperature: Double
    let isDay: Float
    let rain: Float
    let showers: Float
    let windSpeed: Float
    let snowfall: Float
    let windDirection: Float
}

struct APIHourly: Decodable {
    let weatherCode: [Int]
    let time: [String]
    let temperature: [Double]
    let showers: [Float]
    let snowfall: [Float]
    let windSpeed: [Float]
    let rain: [Float]
    let isDay: [Float]
}

struct APIDaily: Decodable {
    let weatherCode: [Int]
    let time: [String]
    let temperatureMax: [Double]
    let temperatureMin: [Double]
}



    
