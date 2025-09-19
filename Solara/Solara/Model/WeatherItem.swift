//
//  File.swift
//  Solara
//
//  Created by Zeynep Cankaya on 21.08.2025.
//

import Foundation

struct WeatherItem : Identifiable {
   
    let id = UUID()
    let city : String
    let temp : WeatherData
}


    
