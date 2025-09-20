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
    let formatter : WeatherFormatter
    @Binding var selectedUnit : Bool
    var displayTemp : Double {
        selectedUnit ? formatter.celciusToFarenheit(temp) : temp
    }
    var displayMaxTemp : Double {
        selectedUnit ? formatter.celciusToFarenheit(maxTemp) : maxTemp
    }
    var displayMinTemp : Double {
        selectedUnit ? formatter.celciusToFarenheit(minTemp) : minTemp
    }
    
    var body: some View {
        VStack{
            Text("\(formatter.formatTemperature(displayTemp))")
                .font(.system(size: 60, weight: .light))
                .padding()
            
            HStack{
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("H:\(formatter.formatTemperature(displayMaxTemp))")
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("L:\(formatter.formatTemperature(displayMinTemp))") }
            
        }
    }
}
