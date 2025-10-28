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
    
    let modelContainer : ModelContainer
    let weatherRepository : WeatherRepositoryProtocol
    let weatherService : WeatherServiceProtocol
    let geoService : GeoServiceProtocol
    let mapper: Mapper
    
    @StateObject var cityListViewModel : CityListViewModel
    @StateObject var weatherSearchViewModel : WeatherSearchViewModel
    @StateObject var coordinator: WeatherCoordinator
    
    init() {
        
        let container: ModelContainer
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
            container = try ModelContainer(for: schema, configurations: [configuration])
        }catch {
            fatalError("ModelContainer could not be initialized:\(error) ")
        }
       
        self.modelContainer = container
        
        let mapper = Mapper()
        let weatherService = WeatherService()
        let geoService = GeoService()
        
        let weatherRepository = WeatherRepository(container:container, mapper: mapper)
        
        self.mapper = mapper
        
        self.weatherService = weatherService
        self.geoService = geoService
        
        self.weatherRepository = weatherRepository
        
        let cityListVM = CityListViewModel(
                    repository: weatherRepository,
                    service: weatherService,
                    geoService: geoService
                )
                self._cityListViewModel = StateObject(wrappedValue: cityListVM)
                
        let weatherSearchVM = WeatherSearchViewModel(
                    geocodeService: geoService
                )
                self._weatherSearchViewModel = StateObject(wrappedValue: weatherSearchVM)
        
        let coordinator = WeatherCoordinator(cityListViewModel: cityListVM,
                                             searchViewModel: weatherSearchVM,
                                             service: weatherService,
                                             mapper: mapper
        )
        self._coordinator = StateObject(wrappedValue: coordinator)
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
             
        }
        .modelContainer(modelContainer)
        
        .environmentObject(cityListViewModel)
        .environmentObject(weatherSearchViewModel)
        .environmentObject(coordinator)
    }
}

