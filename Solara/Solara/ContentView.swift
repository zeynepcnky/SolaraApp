//
//  ContentView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    @StateObject private var coordinator = WeatherCoordinator()
  
    @State private var showSettings: Bool = false
    @State private var isEditing: Bool = false
    @State private var selectedUnit = false
    
  
    var body : some View {
        NavigationView {
            VStack{
                
                if !coordinator.isSearchableActive {
                    CardListView (
                        coordinator: coordinator,
                        cities: coordinator.addedCity,
                        onSelect: { city in coordinator.select(city)},
                        isEditing: $isEditing,
                        selectedUnit: $selectedUnit)
                } else {
                    WeatherSearchView(
                        cityName: $coordinator.cityName,
                        onSelect: {  coordinator.startSearch() })
                }
            }
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        withAnimation { showSettings.toggle()}
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            } .navigationTitle("☀️ Solara")
        }
            .onAppear{
                coordinator.setupContext(context)
            }
            
            
            .sheet(item: $coordinator.selectedWeather){ (weather: WeatherData) in
                CityView(viewModel: coordinator.viewModel,
                         city: weather.city,
                         isFromSearch: false,
                         selectedUnit: $selectedUnit)
            }
            
            .sheet(isPresented: $coordinator.isSheetActive){
                CityView(viewModel: coordinator.viewModel, city: coordinator.cityName,onAdd: {coordinator.addCity()}, isFromSearch: true,
                         selectedUnit: $selectedUnit)
            }
            
            .searchable(
                text : $coordinator.cityName,
                isPresented: $coordinator.isSearchableActive,
                prompt: "Search a City")
            
            .onSubmit(of: .search) { coordinator.startSearch()}
           
      
        
        
        .overlay{ SettingsOverlay(isVisible: $showSettings, selectedUnit: $selectedUnit){
            showSettings = false
            isEditing = true
          }
        }
    }
}

#Preview { ContentView() }
