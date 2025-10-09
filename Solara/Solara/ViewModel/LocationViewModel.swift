//
//  LocationViewModel.swift
//  Solara
//
//  Created by Zeynep Cankaya on 22.09.2025.
//

import Foundation
import CoreLocation
@MainActor
class LocationViewModel: ObservableObject {
    @Published var weather : APIWeatherData?
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var cityName: String = "Unknown"
    
    private let weatherService = WeatherService()
    private let locationManager = LocationManager()
    private let geocoder = CLGeocoder()
    
    init() {
        locationManager.onLocationUpdate = { [weak self] coordinate in
           Task {
               guard let self = self else { return }
                self.currentLocation = coordinate
               
               
               await self.getLocationWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
    }
    
    func getLocationWeather(lat: Double, lon: Double) async {
        do{
            let data = try await weatherService.fetchWeather(latitude: lat, longitude: lon)
            self.weather = data
            
            
        } catch{
            print("Location View Model:\(error)")
        }
    }
    
    
}
