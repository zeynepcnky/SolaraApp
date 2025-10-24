//
//  Untitled.swift
//  Solara
//
//  Created by Zeynep Cankaya on 9.09.2025.
//

import Foundation
import SwiftUI

struct HourlyForecastView: View {
    let date : Date
    let temp : Double
    
    let weatherCode: Int
    let timezoneIdentifier: String
    @Binding var selectedUnit : Bool
    
    var displayTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(temp) : temp
    }
    
    var body: some View {
        let weatherIcon = WeatherIcon(code: weatherCode)
        VStack(alignment: .leading) {
             
                Text(WeatherFormatter.formatHour(for: date, with: timezoneIdentifier))
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
            
            Image(weatherIcon.assetName)
                .resizable()
                .frame(width: 20, height: 20)
            
            Text("\(WeatherFormatter.formatTemperature(displayTemp))")
                .foregroundColor(Color(.darkBlue))
                
            
        }
    }
}

