//
//  LocationManager.swift
//  Solara
//
//  Created by Zeynep Cankaya on 20.09.2025.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let manager =  CLLocationManager()
    
    internal var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?
    
   
    
    
    
    override init() {
        super.init()
        manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 50.0
        self.manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    
        }
        
    
    
    func onUpdate(_ completion: @escaping (CLLocationCoordinate2D) -> Void){
        self.onLocationUpdate = completion
        
    }
    
    func startUpdating() {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        onLocationUpdate?(currentLocation.coordinate)
    }
}
