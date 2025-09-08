//
//  Untitled.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.09.2025.
//

import SwiftUI
import Foundation

struct SettingsView : View {
    
    @State private var isCelcius = true
    
    var body: some View {
        NavigationView {
            List{
                Section{
                    HStack{
                        Button("Edit List") { print ("Tapped Edited List") }
                          Spacer()
                        Image(systemName: "pencil")
                                                }
                    HStack{
                        Button("Notifications"){ print("Notifications Tapped") }
                        Spacer()
                        Image(systemName: "bell")
                          
                    }
                    
                    Picker("Temperature Unit", selection: $isCelcius){
                        Text("Santigrat").tag(true)
                        Text("Fahrenheit").tag(false)
                    }
                    .pickerStyle(.segmented)
                   
                   
                    HStack{
                        Button("Units"){ print("units Tapped")}
                          Spacer()
                    Image(systemName: "chart.bar.fill")
                            .padding(.leading, 100)
                    }
                   
                    HStack{
                        Button("Report issue"){ print("Report a issue tapped")}
                            .foregroundStyle(.red)
                        Spacer()
                        Image(systemName: "exclamationmark.triangle")
                            .padding(.leading, 100)
                    }
                    
                }
            }.listStyle(GroupedListStyle())
        }
    }
}
       
    

