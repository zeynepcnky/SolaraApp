//
//  ForecastDayView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//

import SwiftUI

struct ForecastDayView : View {
    let dateString: String
    let maxTemp: Double
    let minTemp: Double
    let formatter : WeatherFormatter
    
     var body : some View {
         VStack(spacing: 4) {
             if let date = formatter.dailyDateFromString(dateString) {
                 Text(formatter.formatDay(date))
                     .font(.headline)
                     .frame(alignment: .center)
                }
             Image(systemName: "sun.max")
                 .font(.system(size: 25))
                 .frame(alignment: .center)
             
             HStack {
                 Image(systemName: "thermometer.sun")
                     .font(.system(size: 20))
                 
                 Text("\(formatter.formatTemperature(minTemp))")
                     .foregroundStyle(.blue)
                     .font(.headline)
             }
          HStack {
              Image(systemName: "thermometer.sun")
                  .font(.system(size: 20))
              Text("\(formatter.formatTemperature(maxTemp))")
                  .foregroundStyle(.red)
                  .font(.headline)
             }
          .padding(.vertical, 4)
             
         }
         .frame(width: 115, height: 165)
         .background(Color(.systemBlue).opacity(0.2))
         .cornerRadius(12)
         .shadow(color: Color.blue.opacity(0.05), radius: 3, x: 0, y:2)
    }
}
