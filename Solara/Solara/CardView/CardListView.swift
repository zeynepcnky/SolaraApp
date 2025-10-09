//
//  WeatherCardListView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//

import Foundation
import SwiftUI

struct CardListView: View {
    @ObservedObject var coordinator: WeatherCoordinator
    let cities: [WeatherData]
    let onSelect : (WeatherData) -> Void
    @Binding var isEditing: Bool
    @Binding var selectedUnit : Bool
   
    @State private var editMode: EditMode = .inactive
    
   
    
    
    var body: some View {
        ZStack {
            
            if !cities.isEmpty {
                List {
                    ForEach(cities) { city in
                        CardView(city: city.city,
                                 temperature: city.current.temperature,
                                 weatherCode: city.current.weatherCode,
                                 selectedUnit: $selectedUnit)
                            .onTapGesture { onSelect(city) }
                        
                    }
                    .onDelete(perform: coordinator.deleteCity)
                    .onMove(perform: coordinator.moveCity)
                    
                }
              
                .environment(\.editMode, $editMode)
            }
                
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        
        .onChange(of: isEditing, perform: {  value in
            withAnimation {
                editMode = value ? .active : .inactive
                
            }
          
        })
    }
}
