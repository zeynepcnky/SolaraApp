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
   /** var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()**/

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
       // .modelContainer(sharedModelContainer)
    }
}
