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
    var temp : Double?
    var onAdd : (() -> Void)? = nil
    var isFromSearch : Bool
    @Environment(\.dismiss) var dismiss
    //@Binding var selectedUnit : Bool
 
    private let formatter = WeatherFormatter()
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    cityHeader
                    currentWeather
                    Divider()
                    HourlySection
                        .padding()
                    forecastSection
                }
                .toolbar {
                    if isFromSearch {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { dismiss() }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                onAdd?()
                                dismiss()
                            }
                        }
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
            if let currentCode = viewModel.weather?.current.weatherCode {
                let weatherIcon = WeatherIcon(code: currentCode)
                Image(weatherIcon.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 95)
            }
        }
    }
    
    private var currentWeather: some View {
        let temp = viewModel.weather?.current.temperature ?? 0.0
        let maxTemp = viewModel.weather?.daily.temperatureMax.first ?? 0.0
        let minTemp = viewModel.weather?.daily.temperatureMin.first ?? 0.0
        
        return VStack{
            Text("\(formatter.formatTemperature(temp))")
                .font(.system(size: 60, weight: .light))
                .padding()
            
            HStack{
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("H:\(formatter.formatTemperature(maxTemp))")
                
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("L:\(formatter.formatTemperature(minTemp))") }
            
        }
    }
    
    private var forecastSection : some View {
        VStack(alignment: .leading){
            Text("Day Forecast")
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
                                formatter: formatter,
                                weatherCode: forecast.weatherCode[index]
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
        }
    }
    
    private var HourlySection : some View {
        VStack(alignment: .leading){
            Text("Hourly Weather Forecast")
                .font(.headline)
                .padding(.horizontal)
            Divider()
            if let hourlyForecast = viewModel.weather?.hourly {
                
                let now = Date()
                
                let filteredForecast = hourlyForecast.time.enumerated().compactMap { index, hourString -> Int? in
                    if let forecastDate = formatter.hourFromString(hourString) {
                        
                        return forecastDate >= now ? index : nil
                    }
                    return nil
                }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12){
                            ForEach(filteredForecast, id:\.self) { index in
                                HourlyForecastView(hour: hourlyForecast.time[index],
                                                   temp: hourlyForecast.temperature[index],
                                                   formatter: formatter,
                                                   weatherCode: hourlyForecast.weatherCode[index]
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        
    }


