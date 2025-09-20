//
//  Untitled.swift
//  Solara
//
//  Created by Zeynep Cankaya on 9.09.2025.
//

import Foundation
import SwiftUI

struct HourlyForecastView: View {
    let hour : String
    let temp : Double
    let formatter : WeatherFormatter
    let weatherCode: Int
    @Binding var selectedUnit : Bool
    
    var displayTemp : Double {
        selectedUnit ? formatter.celciusToFarenheit(temp) : temp
    }
    
    var body: some View {
        let weatherIcon = WeatherIcon(code: weatherCode)
        VStack(alignment: .leading) {
            if let hourly = formatter.hourFromString(hour) {
                Text(formatter.formatHour(hourly))
                    .font(.headline)
                    .frame(alignment: .leading)
            }
            Image(weatherIcon.assetName)
                .resizable()
                .frame(width: 20, height: 20)
            
            Text("\(formatter.formatTemperature(displayTemp))")
                
            
        }
    }
}

