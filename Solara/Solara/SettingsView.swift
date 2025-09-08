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
            List {
                Section(header: Text("General")) {
                    Button("Edited List") {
                        print ("Tapped Edited List")
                    }
                    Button("Notifications"){
                        print("Notifications Tapped")
                    }
                }
                Section(header: Text("Units")) {
                    Picker("Temperature Unit", selection: $isCelcius){
                        Text("Santigrat").tag(true)
                        Text("Fahrenheit").tag(false)
                    }
                    .pickerStyle(.segmented)
                    
                }
                Section {
                    Button("Units"){
                        print("units Tapped")
                    }
                    Section(header: Text("Support")) {
                        Button("Report issue"){
                            print("Report a issue tapped")
                        }
                        .foregroundStyle(.red)
    
                    }
                }
                
            }
        }
       
    }
}
