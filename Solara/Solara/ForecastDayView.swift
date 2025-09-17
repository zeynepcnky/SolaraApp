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
    let weatherCode : Int
    
     var body : some View {
         let weatherIcon = WeatherIcon(code: weatherCode )
         VStack(spacing: 4) {
             if let date = formatter.dailyDateFromString(dateString) {
                 Text(formatter.formatDay(date))
                     .font(.headline)
                     .frame(alignment: .center)
                }
             Image(weatherIcon.assetName)
                 .resizable()
                 .scaledToFit( )
                 .frame(width: 40, height: 40, alignment: .center)
             
             HStack {
                 Image("Image")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 20, height: 20)
                 
                 Text("\(formatter.formatTemperature(minTemp))")
                     .foregroundStyle(.blue)
                     .font(.headline)
             }
          HStack {
              Image("Image")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 20, height: 20)
              
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
