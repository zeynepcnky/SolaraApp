//
//  WeatherRepository.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.10.2025.
//

import SwiftData
import Foundation

@MainActor
protocol WeatherRepositoryProtocol {
    
    
    func fetchAllCities() throws -> [WeatherData]
    
    func addCity(from apiData: APIWeatherData, coordinate: GeocodeResult) async throws -> WeatherData
    func delete(city: WeatherData) throws
    func refresh(cityToUpdate: WeatherData, with apiData: APIWeatherData) throws
}

@MainActor
class WeatherRepository: WeatherRepositoryProtocol {
   
   // private let context : ModelContext
    private let container : ModelContainer
    private let mapper :  Mapper
    
    @MainActor
    private var mainContext : ModelContext {
        container.mainContext
    }
    
    
    init( container: ModelContainer,
         mapper : Mapper ) {
        self.container = container
        self.mapper = mapper
       
    }
  
    func fetchAllCities() throws -> [WeatherData] {
        let descriptor = FetchDescriptor<WeatherData>( sortBy: [SortDescriptor(\.city)] )
        
        do{
            return try mainContext.fetch(descriptor)
        } catch{
            print("Repository Fetch : \(error)")
            throw error
        }
    }
    func addCity(from apiData: APIWeatherData, coordinate: GeocodeResult) async throws -> WeatherData {
        
        let context = mainContext
       
        do {
            let cityName = coordinate.name
            let admin1 = coordinate.admin1
            
            let predicate = #Predicate<WeatherData> {
                $0.city == cityName && $0.admin1 == admin1
            }
            let fetchDescriptor = FetchDescriptor<WeatherData>(predicate: predicate)
            
            let existingCity = try context.fetch(fetchDescriptor)
            
            if let existingCity = existingCity.first {
                return existingCity
            }else {
                let newCity = mapper.map(apiData: apiData, coordinate: coordinate)
                context.insert(newCity)
                try context.save()
                print("✅ \(coordinate.name) successfully saved.")
                
                return newCity
            }
            
            
}
        catch {
            print("City not saved: \(error)")
            throw error
                }
        
    }
    

    func delete(city: WeatherData) throws  {
        
        guard let context = city.modelContext else {
            print("❌ Delete failed: Model context bulunamadı.")
            return
        }
        context.delete(city)
        do{
          try  context.save()
            print("✅ City \(city.city) successfully deleted.")
        }catch {
        print("❌ Delete failed : \(city.city) \(error)")
            context.insert(city)
           throw error
        }
       
    }
    

    func refresh(cityToUpdate: WeatherData, with apiData: APIWeatherData) throws{
        
        mapper.update(existingData: cityToUpdate, with: apiData)
        
        do {
            try mainContext.save()
            print("Repository Update : \(cityToUpdate.city) successfully updated.")
        }
        catch {
            print("Repository Update Error : \(error)")
            throw error
        }
    }

}



