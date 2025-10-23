//
//  WeatherSearchView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation
import SwiftUI

struct WeatherSearchResultView: View {
    
    @ObservedObject var viewModel : WeatherSearchViewModel
    
    let onCitySelected : (GeocodeResult) -> Void
    
    var body : some View {
        VStack{
            List(viewModel.searchCoordinate) { city in
                Button(action: {
                    onCitySelected(city)
                } ) {
                    VStack(alignment: .leading){
                        Text(city.name).font(.headline)
                        
                        Text([city.admin1, city.country].compactMap { $0 }.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            .listStyle(PlainListStyle())
            
            if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 12){
                    Image(systemName:"exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color(.red))
                    Text("Search Error")
                        .font(.headline)
                    Text(errorMessage)
                }
                
            }
            
        }
    }
}

    

