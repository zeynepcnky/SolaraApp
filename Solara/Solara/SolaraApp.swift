//
//  SolaraApp.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import SwiftUI
import SwiftData

@main
struct SolaraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: [WeatherData.self, Current.self, Hourly.self, Daily.self])
    }
}
