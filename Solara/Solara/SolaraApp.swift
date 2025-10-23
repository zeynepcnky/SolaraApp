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
    var sharedModelContainer: ModelContainer = {
        do{
            let schema = Schema([
                WeatherData.self,
                Current.self,
                Hourly.self,
                Daily.self
            ])
            let configuration = ModelConfiguration (
                schema: schema,
                isStoredInMemoryOnly: false
            )
            return try ModelContainer(for: schema, configurations: [configuration])
        }catch {
            fatalError("ModelContainer could not be initialized")
        }
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
             
        }
        .modelContainer(sharedModelContainer)
    }
}
