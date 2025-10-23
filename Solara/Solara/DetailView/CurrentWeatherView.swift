//
//  CurrentWeatherView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 20.09.2025.
//
import SwiftUI
struct CurrentWeatherView : View {
    let temp : Double
    let maxTemp : Double
    let minTemp : Double
   
   
    @Binding var selectedUnit : Bool
    var displayTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(temp) : temp
    }
    var displayMaxTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(maxTemp) : maxTemp
    }
    var displayMinTemp : Double {
        selectedUnit ? WeatherFormatter.celciusToFarenheit(minTemp) : minTemp
    }
    
    var body: some View {
      
           
            VStack{
                Text("\(WeatherFormatter.formatTemperature(displayTemp))")
                    .font(.system(size: 60, weight: .light))
                    .padding()
                    .foregroundStyle(.white)
                
                HStack{
                
                    Text("H:\(WeatherFormatter.formatTemperature(displayMaxTemp))")
                        .foregroundStyle(.red)
                        .font(Font.title3.bold())
                    
                        .padding(.all)
                    
               
                    Text("L:\(WeatherFormatter.formatTemperature(displayMinTemp))")
                        .foregroundStyle(.darkBlue)}
                .font(Font.title3.bold())
                
            }
        
    }
}
