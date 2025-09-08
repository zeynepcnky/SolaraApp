//
//  GeoService.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import Foundation

struct GeoService {
    
    static let shared = GeoService()
    
    func getGeoData(cityName : String) async throws -> GeocodeResult? {
        let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://geocoding-api.open-meteo.com/v1/search?name=\(encodedCity)&count=1&language=en&format=json"
        
        guard let url = URL(string: urlString) else{
            throw URLError(.badURL)
        }
        let (data,_) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = try JSONDecoder().decode(Geocode.self, from: data)
            //print(String(data: data, encoding: .utf8)!)
            return decoder.results?.first
        }
        catch{
            print("Geo Decode Error\(error)")
            throw error
            
        }
    }
    
}
