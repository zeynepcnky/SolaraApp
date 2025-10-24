//
//  ContentView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
   @StateObject private var coordinator = WeatherCoordinator()
    
    @State private var showSettings: Bool = false
    @State private var isEditing: Bool = false
    @State private var selectedUnit : Bool = false
    @State private var isSearchActive : Bool = false
    
    @Environment(\.modelContext) private var context
    
    var body : some View {
        NavigationStack{
            VStack{
                if isSearchActive {
                    WeatherSearchResultView(viewModel: coordinator.viewModel, onCitySelected: coordinator.selectCityFromSearch) }
                
                else {
                    VStack{
                        Image(systemName:"sun.max")
                            .foregroundColor(.darkBlue)
                        
                        
                        Text("Solara")
                            .font(Font.largeTitle)
                            .fontDesign(Font.Design.rounded)
                            .foregroundColor(.darkBlue)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                    
                    
                    List{
                        ForEach(coordinator.cityListViewModel.addedCity) { city in
                            Button(action: {
                                coordinator.selectedCityForDetail = city
                            }) {
                                CardView(cityData: city , selectedUnit: $selectedUnit)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: coordinator.cityListViewModel.deleteCity)
                        .onMove(perform: coordinator.cityListViewModel.moveCity)
                        
                    }
                    .listStyle(.plain)
                    .environment(\.editMode, .constant(isEditing ? .active : .inactive))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        withAnimation { showSettings.toggle()}
                    }label: { Image(systemName: "ellipsis") }
                }
            }
            
            .searchable(
                text: $coordinator.viewModel.searchText,
                isPresented: $isSearchActive,
                prompt: "Search for a city"
            )
            .sheet(item: $coordinator.searchedCityDetail){ city in
                CityView(weatherData: city,
                         onAdd: { coordinator.addLastSearchedCity()},
                         isFromSearch: true,
                         selectedUnit: $selectedUnit)
            }
            .sheet(item: $coordinator.selectedCityForDetail){ city in
                CityView(weatherData: city,
                         onAdd: {},
                         isFromSearch: false,
                         selectedUnit: $selectedUnit)
                .onAppear{coordinator.cityListViewModel.stopUpdateLoop()}
                .onDisappear {coordinator.cityListViewModel.startUpdateLoop()}
                
            }

        .overlay{ SettingsOverlay(
                isVisible: $showSettings,
                selectedUnit: $selectedUnit,
                onEdit: {
                    showSettings = false
                    isEditing.toggle()
                }
            )
            }
        }
    
        .onAppear{ coordinator.setup(with: context, isSearchActive: $isSearchActive) }
       
            
            
            
        }
    }

#Preview { ContentView() }
