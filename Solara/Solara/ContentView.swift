//
//  ContentView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {

 
@StateObject var viewModel = WeatherViewModel()
@State var cityName: String = ""
    
    var body : some View {
        VStack{
            
            if !cityName.isEmpty {
                Text("\(cityName)")
                    .font(.headline)
                    .padding()
            }
                
            TextField("City Name", text: $cityName)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .opacity(0.1)
                        .frame(height: 30)
                )
                .padding( )
           Button("Get Weather") {
                Task{
                    await viewModel.getWeather(cityName: cityName)
                    }
                }
                
            }
            .padding( )
            
        if let temp = viewModel.weather?.current.temperature{
                Text("\(temp) °C")
            let lat = viewModel.coordinate?.latitude ?? 0.0
            let lon = viewModel.coordinate?.longitude ?? 0.0
            
            Text("Latitude of City: \(lat)")
            Text("Longitude of City: \(lon)")
            
            }
            else {
                Text("No Data")
            }
        
        }
        
    }


#Preview {
    ContentView()
        
}
