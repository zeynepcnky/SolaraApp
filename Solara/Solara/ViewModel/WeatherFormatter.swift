//
//  WeatherFormatter.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation

struct WeatherFormatter {
    private let inputDateFormatter : DateFormatter
    private let outputDateFormatter : DateFormatter
    private let outputHourFormatter : DateFormatter
    init() {
       inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "E"
        outputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        outputHourFormatter = DateFormatter()
        outputHourFormatter.dateFormat = "HH"
        outputHourFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    func dateFromString(_ input: String) -> Date? {
        inputDateFormatter.date(from: input)
    }
    
    func formatDay(_ date : Date) -> String {
        outputDateFormatter.string(from: date)
    }
    
    func formatHour(_ date : Date) -> String {
        outputHourFormatter.string(from: date)
    }
    
    func formatTemperature(_ temperature: Double) -> String {
        String(format: "%.0f°", temperature)
    }
    
}
