//
//  CityListViewModel.swift
//  Solara
//
//  Created by Zeynep Cankaya on 15.10.2025.
//

import Foundation
import SwiftData

@MainActor
final class CityListViewModel: ObservableObject {
    @Published var  addedCity : [WeatherData] = []
        
    private var repository : WeatherRepository?

    private var service  = WeatherService()
    private let geoService = GeoService()
    
    private var updateTask: Task <Void, Never>? = nil
    private let updateTime: TimeInterval = 600
    
    
    func setupContext(_ context: ModelContext){
        self.repository = WeatherRepository(context: context)
        loadSavedCities()
        startUpdateLoop()
    }
    
    func fetchWeather(city: GeocodeResult) async {
        do {
            
            let apiData = try await service.fetchWeather(latitude: city.latitude, longitude: city.longitude)
            let cityName = city.name.lowercased()
            let admin = city.admin1?.lowercased()
            
            let existingCity = addedCity.first {
                $0.city.lowercased() == cityName &&
                $0.admin1?.lowercased() == admin
                }
            
            if let existingCity = existingCity {
                repository?.update(existingCity: existingCity, with: apiData)
                
            }else {
                if let newCity = await repository?.createCity(from: apiData, coordinate: city){
                    addedCity.append(newCity)
                    print("✅ \(newCity.city) added to context.")
                } else {
                    print("❌ City Lİst View Model: createCity returned 'nil', save failed ")
                }
            }
            try repository?.save()
            
            } catch{ print("❌ City Lisr View Model: \(error.localizedDescription)") }
        }
    
    func deleteCity(at offsets: IndexSet) {
       
        guard let repository = self.repository else { return }
        stopUpdateLoop()
        
        let citiesToDelete = offsets.map { addedCity[$0] }
        
        do{
            for city in citiesToDelete {
                repository.delete(city: city)
            }
            
            try repository.save()
            addedCity.remove(atOffsets: offsets)
            }
        catch{ print("❌ Failed to delete cities from database: \(error.localizedDescription)")}
        
        startUpdateLoop()
    }
    
    func moveCity(from source : IndexSet, to destination: Int) {
        addedCity.move(fromOffsets: source, toOffset: destination)
    }
    
    
    func loadSavedCities(){
        guard let repository = self.repository else { return }
        do{
            self.addedCity = try repository.fetchAllCities()
        }
        catch{ print("❌ Error loading cities: \(error.localizedDescription)")}
    }

    func startUpdateLoop(){
        
        updateTask?.cancel()
        updateTask = Task { [weak self] in
            while !Task.isCancelled {
                print("🔄 Starting update for all cities...")
                
                guard let self = self else {
                    print("ℹ️ ViewModel deallocated. Stopping update loop.")
                    break
                    }
                
                await fetchUpdatesForAllCities()
                
                do {
                    try await Task.sleep(for: .seconds(updateTime))
                }catch{
                    print("ℹ️ Update loop task was canceled.")
                    break
                }
            }
        }
    }
    
    func stopUpdateLoop() {
        updateTask?.cancel()
        updateTask = nil
        print("⏸️ Update task stopped.")
    }
    
    private func fetchUpdatesForAllCities() async {
        guard let repository = self.repository else { return }
        
        let citiesToUpdate = self.addedCity.map {($0.city, $0.admin1)}
        
        let backgroundContext = ModelContext(repository.context.container)
        let backgroundRepo = WeatherRepository(context: backgroundContext)
        
        for (cityName, admin1) in citiesToUpdate {
            do {
                let geoResult = try await geoService.getGeoData(cityName: cityName)
                
                guard let firstResult = geoResult.first else {
                    print("❌ Update failed: Could not find coordinates for \(cityName).")
                    continue
                }
                
                let newAPIData = try await service.fetchWeather(latitude: firstResult.latitude, longitude: firstResult.longitude)
                
                let predicate = #Predicate<WeatherData> { $0.city == cityName && $0.admin1 == admin1 }
                let descriptor = FetchDescriptor(predicate: predicate)
                
                
                if let cityToUpdate = try backgroundContext.fetch(descriptor).first {
                    
                    backgroundRepo.update(existingCity: cityToUpdate, with: newAPIData)
                }
                
                try? await Task.sleep(for: .milliseconds(500))
                
            } catch { print("❌ Error fetching city for update: \(error.localizedDescription)") }
        }
        
        do{
            try backgroundRepo.save()
            print("✅ Background context successfully saved.")
            
        }catch{ print("❌ Failed to save background context: \(error.localizedDescription)") }
        
            await MainActor.run {
                self.loadSavedCities()
                print(" ✅ Update cycle completed successfully.")
        }
    }
}
