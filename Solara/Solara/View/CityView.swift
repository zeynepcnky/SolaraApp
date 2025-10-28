//
//  CityView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CityView: View {
    
    @StateObject var viewModel : CityViewModel
    
    var onAdd : (() -> Void)? = nil
    var isFromSearch : Bool
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedUnit : Bool
 
    private let formatter = WeatherFormatter()
    
    init(weatherData: WeatherData, onAdd: (()-> Void)? = nil, isFromSearch: Bool, selectedUnit: Binding<Bool>) {
                _viewModel = StateObject(wrappedValue: CityViewModel(cityData: weatherData))
               self.onAdd = onAdd
               self.isFromSearch = isFromSearch
               self._selectedUnit = selectedUnit
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16){
                    cityHeader
                    currentWeather
                    HourlySection
                    forecastSection
                }
            }
            .background(
                LinearGradient(
                gradient: Gradient(colors: [Color("LightBlue"), Color("DarkBlue")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
        ))
            .toolbar {
                if isFromSearch {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") { onAdd?()}
                    }
                }
            }
        }.padding(.top, 10)
    }
   
    private var cityHeader: some View {
        VStack{
            Text(viewModel.cityName)
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .padding(.top, 70)
          
            Image(viewModel.headerIcon.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 95)
                    .padding(.top, 10)
        }
    }
    
    private var currentWeather: some View {
      return VStack{
            CurrentWeatherView(
                temp: viewModel.currentTemperature,
                maxTemp: viewModel.maxTemperature,
                minTemp: viewModel.minTemperature,
                selectedUnit: $selectedUnit)
        }
      
    }
    
    private var forecastSection : some View {
        VStack(alignment: .leading){
            Text("Day Forecast")
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.horizontal)
            Divider()
            
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12){
                        ForEach(viewModel.dailyForecasts, id: \.date) { day in
                            ForecastDayView(
                                date : day.date ?? Date(),
                                maxTemp: day.temperatureMax,
                                minTemp: day.temperatureMin,
                                weatherCode: day.weatherCode,
                                selectedUnit: $selectedUnit
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
    }
    
    private var HourlySection : some View {
        VStack(alignment: .leading){
            Text("Hourly Weather Forecast")
                .foregroundStyle(.white)
                .font(.headline)
                .padding(.horizontal)
          
            Divider()
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12){
                ForEach(viewModel.hourlyforecasts, id: \.date) { hour in
                    HourlyForecastView(date: hour.date ?? Date(),
                                       temp: hour.temperature,
                                       weatherCode: hour.weatherCode,
                                       timezoneIdentifier: viewModel.timeZoneIdentifier,
                                       selectedUnit: $selectedUnit
                                )
                            }
                        }
                        
                    .padding(.horizontal)
                }
            }
        }
        
    }


