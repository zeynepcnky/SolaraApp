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
    @Published var errorMessage : String?
    @Published var isLoading : Bool = false
     
    private let repository : WeatherRepositoryProtocol
    private let service : WeatherServiceProtocol
    private let geoService : GeoServiceProtocol

    
    private var updateTask: Task <Void, Never>? = nil
    private let updateTime: TimeInterval = 600
    
    init(repository: WeatherRepositoryProtocol,
         service : WeatherServiceProtocol,
         geoService : GeoServiceProtocol) {
        self.repository = repository
        self.service = service
        self.geoService = geoService
        
        loadSavedCities()
        startUpdateLoop()
    }
    
    
    func fetchWeather(city: GeocodeResult) async {
       
        isLoading = true
        errorMessage = nil
        
        do {
            
            let cityName = city.name.lowercased()
            let admin = city.admin1?.lowercased()
            let alreadyExists = addedCity.contains {
            $0.city.lowercased() == cityName && $0.admin1?.lowercased() == admin
                
            }

            guard !alreadyExists else {
                errorMessage = "\(cityName) already added."
            isLoading = false
            return
        }
            
        let apiData = try await service.fetchWeather(latitude: city.latitude, longitude: city.longitude)
            
        _ = try await repository.addCity(from: apiData, coordinate: city)
            
            loadSavedCities()
           
            
        } catch{
            print("❌ City List View Model: \(error.localizedDescription)")
            errorMessage = "City could not be added. \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func deleteCity(at offsets: IndexSet) {
       
        let citiesToDelete = offsets.map { addedCity[$0] }
        
        do{
            
            for city in citiesToDelete {
                
            try repository.delete(city: city)
            }
            addedCity.remove(atOffsets: offsets)
            }
        
        catch{
            print("❌ Failed to delete cities from database: \(error.localizedDescription)")
            errorMessage = "Delete failed. \(error.localizedDescription)"
        }
    }
    
    func moveCity(from source : IndexSet, to destination: Int) {
        addedCity.move(fromOffsets: source, toOffset: destination)
    }
    
    
    func loadSavedCities(){
        
        do { self.addedCity = try repository.fetchAllCities() }
       
        catch{
            print("❌ Error loading cities: \(error.localizedDescription)")
            errorMessage = "City list could not be loaded. \(error.localizedDescription)"
        }
    }

    func startUpdateLoop(){
        
        updateTask?.cancel()
        updateTask = Task { [weak self] in
            while !Task.isCancelled {
                print("🔄 Starting update for all cities...")
                
                await self?.fetchUpdatesForAllCities()
                
                do {
                    try await Task.sleep(for: .seconds(self?.updateTime ?? 600))
                }
                catch {
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
    
     func fetchUpdatesForAllCities() async {

        
        let citiesToUpdate = self.addedCity
        
        
        for city in citiesToUpdate {
           
            do {
                let newAPIData = try await service.fetchWeather(latitude: city.latitude, longitude: city.longitude)
                
                try repository.refresh(cityToUpdate: city, with: newAPIData)
                
                
            } catch { print("❌ Error fetching city for update: \(error.localizedDescription)") }
        }
        
        self.loadSavedCities()
        print(" ✅ Update cycle completed successfully.")
        
    }
}
