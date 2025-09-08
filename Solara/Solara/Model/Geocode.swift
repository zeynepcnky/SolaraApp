//
//  Geocode.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//
import Foundation



struct Geocode : Decodable {
    let results : [GeocodeResult]?
    let generationTime_ms : Double?
}
struct GeocodeResult : Decodable, Identifiable {
    let id : Int
    let name : String
    let latitude :Double
    let longitude :Double
    
  
}

