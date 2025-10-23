//
//  WeatherCoordinator.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation
import SwiftData


@MainActor
final class WeatherCoordinator: ObservableObject {
    @Published var cityName : String = ""
    @Published var isSearchableActive : Bool = false
    @Published var addedCity : [WeatherData] = []
    @Published var tempWeatherData : WeatherData?
    @Published var isSheetActive : Bool = false
    @Published var selectedWeather : WeatherData?
    @Published var latitude : Double = 0.0
    @Published var longitude : Double = 0.0
    @Published var isLocationActive : Bool = false
    
    let viewModel = WeatherViewModel()
    
    
    private var repository : WeatherRepository?
    private let lastSelectedCityKey = "lastSelectedCityName"
    private var updateTask : Task<Void, Never>? = nil
    private let updateTime : TimeInterval = 600
    
    func setupContext(_ context: ModelContext){
        self.repository = WeatherRepository(context: context)
        loadSavedCities()
        startUpdateLoop()
    }
    
    func startSearch() {
        isSearchableActive = true
        Task {
            defer{
                isSearchableActive = false
            }
            
            await viewModel.getWeather(cityName: cityName)
            
            if let apiData = viewModel.weather {
                self.tempWeatherData = repository?.mapAPIDatatoWeatherData(apiData: apiData, city: cityName)
                isSheetActive = true
                
            }
        }
    }
    
    func addCity() async{
        
        stopUpdateLoop()
        guard let cityToSave = tempWeatherData,
              let apiData = viewModel.weather else { startUpdateLoop()
            return }
        
        if addedCity.contains(where: {$0.city.lowercased() == cityToSave.city}) {
            isSheetActive = false
            startUpdateLoop()
            return
        }
        if let savedCity = await repository?.createAndSaveCity(from: apiData, cityName: cityToSave.city) {
            addedCity.append(savedCity)
        } else{
            print("❌ City could not be saved to the database.")
        }
        
        
        startUpdateLoop()
        isSheetActive = false
        isSearchableActive = false
        tempWeatherData = nil
        viewModel.weather = nil
        
    }
    
    
    func startUpdateLoop(){
        updateTask?.cancel()
        
        updateTask = Task {
            while !Task.isCancelled {
                print("🔄 Starting: Updating all city...")
                await fetchUpdatesForAllCities()
                
                do {
                    try await Task.sleep(for: .seconds(updateTime))
                }catch{
                    print("Task was cancelled")
                    break
                }
            }
        }
    }
    private func fetchUpdatesForAllCities() async {
        guard let repository = self.repository else { return }
        
        let cityNames = self.addedCity.map {$0.city}
           

        
        let backgroundContext = ModelContext(repository.context.container)
        let backgrounRepo = WeatherRepository(context: backgroundContext)
        
        for cityName in cityNames {
            
            
            await viewModel.getWeather(cityName: cityName)
            
            guard let newAPIData = viewModel.weather else {
                print("Update failed: for \(cityName) can not fetch the API data.")
                continue
            }
            
            let predicate = #Predicate<WeatherData> { $0.city == cityName }
            let descriptor = FetchDescriptor(predicate: predicate)
            
            do {
                if let cityToUpdate = try backgroundContext.fetch(descriptor).first {
                    
                    backgrounRepo.update(existingCity: cityToUpdate, with: newAPIData)
                }
            } catch {
                print("❌ Error fetching city to update: \(error)")
            }
            try? await Task.sleep(for: .milliseconds(500))
        }
        
        
        do {
            try backgroundContext.save()
        } catch {
            print("❌ Error saving background context: \(error)")
        }
        
        await MainActor.run {
            self.loadSavedCities()
            print("✅ Update cycle successfully ending.")
        }
    }


    
    func loadSavedCities(){
        guard let repository = self.repository else { return }
        
        do{
            self.addedCity = try repository.fetchAllCities()
           }catch{ print("❌ Şehirler yüklenirken hata oluştu: \(error.localizedDescription)")}
    }

    func select(_ city: WeatherData) {
        selectedWeather = city
        UserDefaults.standard.set(city.city, forKey: lastSelectedCityKey)
    }
    
    func confirmSelected() {
        selectedWeather = nil
    }
    
    func deleteCity(at offsets: IndexSet) {
        guard let repository = self.repository else { return }
        
        stopUpdateLoop()
        
        let citiesToDelete = offsets.map { addedCity[$0] }
        
        do{
            for city in citiesToDelete {
                try repository.delete(city: city)
            }
            addedCity.remove(atOffsets: offsets)
            startUpdateLoop()
        } catch{ print("❌ Cities could not delete from database: \(error)")}
            
        startUpdateLoop()
    }
    func moveCity(from source : IndexSet, to destination: Int) {
        addedCity.move(fromOffsets: source, toOffset: destination)
    }
    
        
    }
    

    extension WeatherCoordinator {
        func stopUpdateLoop() {
            updateTask?.cancel()
        updateTask = nil
        print("⏸ Güncelleme görevi durduruldu.")
    }
}

    

