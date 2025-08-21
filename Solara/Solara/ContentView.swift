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
    
    @State var cityName : String = ""
    @State var isSearchableActive : Bool = false
    @State var addedcity: [WeatherItem] = []
    @State var isSheetActive : Bool = false
   
    var body : some View {
        NavigationView {
            VStack(alignment: .leading){
                
                if !addedcity.isEmpty {
                               ScrollView {
                                   VStack(spacing: 12) {
                                       ForEach(addedcity) { city in
                                                   
                                    CardView(city: city.city , temperature: city.temp.current.temperature )
                                           }
                    
                                       
                                   }
                                   .padding(.vertical)
                               }
                           }
                if isSearchableActive {
                    List{
                        Button(action: {
                            
                            isSheetActive.toggle()
                        }) {
                            Text(cityName)
                        }
                    }
                    .listStyle(PlainListStyle())
                    }
             
                
                
                
                
            }
            .padding()
            
            .navigationTitle("☀️ Solara")
            .searchable(text: $cityName, isPresented: $isSearchableActive, prompt: "Search a city ")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.getWeather(cityName: cityName)
                    isSheetActive = true
                }
                isSearchableActive = false
                
            }
            .sheet(isPresented: $isSheetActive) {
                CityView(viewModel: viewModel, city: cityName) {
                    if let weather = viewModel.weather {
                        let newItem = WeatherItem(city: cityName, temp: weather)
                        
                        if !addedcity.contains(where: { $0.city == cityName}) {
                            addedcity.append(newItem)
                            
                        }
                    }
                    cityName = ""
                   isSheetActive = false
                   isSearchableActive = false
                    
                }
                
            }
            
        }
    }
}
    


#Preview {
    ContentView()
        
}
