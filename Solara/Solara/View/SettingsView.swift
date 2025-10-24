//
//  Untitled.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.09.2025.
//

import SwiftUI
import Foundation

struct SettingsView : View {
  
    @Binding var selectedUnit : Bool 
    private let formatter = WeatherFormatter()
    let onEdit: () -> Void
   
    

    var body: some View {
        NavigationView {
            List{
                HStack{
                    Button("Edit List"){ onEdit() }
                    Spacer()
                    Image(systemName: "pencil")
                    
                }
        
                HStack{
                    Button("Notifications"){  }
                    Spacer()
                    Image(systemName: "bell")
                    
                }
                
                Picker("Temperature Unit", selection: $selectedUnit ){
                    Text("Santigrat").tag(false)
                    Text("Fahrenheit").tag(true)
                    
                }
                .pickerStyle(.segmented)
              
                
                HStack{
                    Button("Units"){ print("units Tapped")}
                    Spacer()
                    Image(systemName: "chart.bar")
                    
                }
                
                HStack{
                    Button("Report issue"){ print("Report a issue tapped")}
                        .foregroundStyle(.red)
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                    
                }
                
                
                
            }.listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
            
        }
        
    }
}
    

