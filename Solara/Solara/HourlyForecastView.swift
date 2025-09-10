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
    
    var body: some View {
        VStack(alignment: .leading) {
            if let hourly = formatter.hourFromString(hour) {
                Text(formatter.formatHour(hourly))
                    .font(.headline)
                    .frame(alignment: .leading)
            }
            Image(systemName: "cloud.sun")
                .font(.system(size: 25))
            
            Text("\(formatter.formatTemperature(temp))")
                
            
        }
    }
}

