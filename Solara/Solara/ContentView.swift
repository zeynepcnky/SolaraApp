//
//  ContentView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Namespace var animation
    @StateObject private var coordinator = WeatherCoordinator()
    @State private var showSettings: Bool = false
    
    
    
    var body : some View {
        NavigationView {
            VStack{
                if !coordinator.isSearchableActive {
                    WeatherCardListView (
                        cities: coordinator.addedCity,
                        animation: animation,
                        onSelect: { city in coordinator.select(city) }
                    )
                } else {
                    WeatherSearchView(
                        cityName: $coordinator.cityName,
                        onSelect: {  coordinator.startSearch() }
                    )
                    
                    
                }
                                }
                .sheet(item: $coordinator.selectedWeather){ weather in
                    CityView(viewModel: coordinator.viewModel,
                             city: weather.city,
                             isFromSearch: false)
                        
                    }
                
            
            .sheet(isPresented: $coordinator.isSheetActive){
                CityView(viewModel: coordinator.viewModel, city: coordinator.cityName,onAdd: {coordinator.addCity()}, isFromSearch: true)
            }
            .searchable(
                text : $coordinator.cityName,
                isPresented: $coordinator.isSearchableActive,
                prompt: "Search a City"
            )
            .onSubmit(of: .search) { coordinator.startSearch()
            }
            .navigationTitle("☀️ Solara")
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        withAnimation { showSettings.toggle()}
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                    
                    
                }
                
            }
        }
            .overlay{ SettingsOverlay(isVisible: $showSettings) }
        }
    }


    

    #Preview {
        ContentView()

    }
