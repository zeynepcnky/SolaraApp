//
//  ForecastDayView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//

import SwiftUI

struct ForecastDayView : View {
    let date: Date
    let maxTemp: Double
    let minTemp: Double
   
    let weatherCode : Int
    @Binding var selectedUnit : Bool
     
    var displayMinTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(minTemp) : minTemp
    }
    var displayMaxTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(maxTemp) : maxTemp
    }
     var body : some View {
         let weatherIcon = WeatherIcon(code: weatherCode )
         VStack(spacing: 4) {
         
                 Text(WeatherFormatter.formatDay(for: date))
                     .font(.headline)
                     .frame(alignment: .center)
                     .foregroundStyle(Color.darkBlue)
                
             Image(weatherIcon.assetName)
                 .resizable()
                 .scaledToFit( )
                 .frame(width: 40, height: 40, alignment: .center)
             
             HStack {
                 Image("Image")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 20, height: 20)
                 
                 Text("\(WeatherFormatter.formatTemperature(displayMinTemp))")
                     .foregroundStyle(.blue)
                     .bold()
                     .font(.headline)
                     
             }
          HStack {
              Image("Image")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 20, height: 20)
              
              Text("\(WeatherFormatter.formatTemperature(displayMaxTemp))")
                  .foregroundStyle(.red)
                  .font(.headline)
             }
          .padding(.vertical, 4)
             
         }
         .frame(width: 115, height: 165)
         .background(Color(.babyBlue))
         .cornerRadius(12)
         .shadow(color: Color.blue.opacity(0.05), radius: 3, x: 0, y:2)
    }
}
