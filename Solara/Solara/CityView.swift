//
//  CityView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CityView: View {
    
    @ObservedObject var viewModel : WeatherViewModel
    var city : String?
    var onAdd : () -> Void
    @Environment(\.dismiss) var dismiss
    
    private let formatter = WeatherFormatter()
    
    var body: some View {
        NavigationView {
           VStack{
                cityHeader
                currentWeather
                Divider()
                forecastSection
            }
           .toolbar {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Cancel") { dismiss() }
               }
               ToolbarItem(placement: .confirmationAction) {
                   Button("Add") {
                       onAdd()
                       dismiss()
                   }
               }
           }
    }
}
    private var cityHeader: some View {
        VStack{
            Text(city ?? "")
                .font(.title2)
                .bold()
                .padding()
            
            Image(systemName: "sun.max")
            .font(.system(size: 100))
            .foregroundStyle(.yellow)
            .padding()
        
        }
    }
    
    private var currentWeather: some View {
        let temp = viewModel.weather?.current.temperature ?? 0.0
        let maxTemp = viewModel.weather?.daily.temperatureMax.first ?? 0.0
        let minTemp = viewModel.weather?.daily.temperatureMin.first ?? 0.0
        
        return VStack{
            Text("Current Temperature: \(formatter.formatTemperature(temp))")
                .font(.system(size: 20, weight: .bold))

            HStack{
                Image(systemName: "thermometer.sun")
                    .font(.system(size: 20))
                Text("Max Temp: \(formatter.formatTemperature(maxTemp))")
                    
                Image(systemName: "thermometer.sun")
                    .font(.system(size: 20))
                Text("Min Temp: \(formatter.formatTemperature(minTemp))") }
            
        }
    }
    
    private var forecastSection : some View {
        VStack(alignment: .leading){
            Text("7-Day Forecast")
                .font(.headline)
                .padding(.horizontal)
            Divider()
            if let forecast = viewModel.weather?.daily {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12){
                        ForEach(0..<forecast.time.count, id:\.self) { index in
                            ForecastDayView(
                                dateString: forecast.time[index],
                                maxTemp: forecast.temperatureMax[index],
                                minTemp: forecast.temperatureMin[index],
                                formatter: formatter )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
        }
    }

}


