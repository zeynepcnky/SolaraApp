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
    
    var body : some View {
        VStack{
        
           Button("Get Weather") {
                Task{
                await viewModel.getWeather(latitude:52.5200 , longitude: 13.4050)
                    }
                }
                
            }
            .padding( )
            
    if let temp = viewModel.weather?.current.temperature{
                Text("\(temp) °C")
            }
            else {
                Text("No Data")
            }
        
        }
        
    }


#Preview {
    ContentView()
        
}
