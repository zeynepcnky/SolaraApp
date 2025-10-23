//
//  CardView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CardView : View {
    
    var cityData : WeatherData

    @Binding var selectedUnit : Bool
    
    private var currentTemperature : Double {
        cityData.current?.temperature ?? 0.0
    }
    private var weatherCode: Int {
        cityData.current?.weatherCode ?? 0
    }
    
   private  var displayedTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(currentTemperature) : currentTemperature
    }
    
    
    var body: some View {
        let weatherIcon = WeatherIcon(code: weatherCode)
        
        HStack(spacing: 16){
            VStack(alignment: .leading, spacing: 6){
                HStack {
                    Text(cityData.city)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                    Text("/ " + (cityData.admin1 ?? ""))
                        .font(.subheadline)
                        .foregroundStyle(Color(.white))
                        }
               
               TimelineView(.everyMinute) { context in
                    Text(WeatherFormatter.formatCurrentTime(for: context.date, with: cityData.timeZoneIdentifier))
                        .font(.subheadline)
                }
                
                Text("\(weatherIcon.description)")
                    .font(Font.footnote)
                    .fontWeight(.medium)
                }
                        
            Spacer()
            
            Text("\(WeatherFormatter.formatTemperature(displayedTemp))")
                .font(.system(size: 48, weight: .medium))
                
        }
        .foregroundStyle(.white)
        .padding(.vertical)
        .padding(.horizontal, 30)
        .frame(height: 125)
        
        .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("babyBlue"), Color("DarkBlue")]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
            )
            
    }
    
}
