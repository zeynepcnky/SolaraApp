//
//  Geocode.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//
import Foundation



struct Geocode : Codable {
    let results : [GeocodeResult]
    
}
struct GeocodeResult : Codable {
    let name : String?
    let latitude :Double
    let longitude :Double
    
  
}

