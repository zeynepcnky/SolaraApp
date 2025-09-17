//
//  WeatherCardListView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//

import Foundation
import SwiftUI

struct WeatherCardListView: View {
    let cities: [WeatherItem]
    let animation : Namespace.ID
    let onSelect : (WeatherItem) -> Void
    
    var body: some View {
        if !cities.isEmpty {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(cities) { city in
                        CardView(city: city.city, temperature: city.temp.current.temperature, weatherCode: city.temp.current.weatherCode)
                            .matchedGeometryEffect(id: city.id, in: animation)
                            .onTapGesture { onSelect(city) }
                        
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

