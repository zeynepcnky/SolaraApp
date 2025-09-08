//
//  WeatherSearchView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation
import SwiftUI

struct WeatherSearchView: View {
    @Binding var cityName : String
    let onSelect : () -> Void
    
    var body : some View {
        List {
            Button(action: onSelect) {
                Text(cityName)
            }
        }
        .listStyle(PlainListStyle())
    }
}
