//
//  WeatherFormatter.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation

struct WeatherFormatter {
    
    static let inputDateFormatter : DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter

    }()
    static let inputHourFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
        
    }()
    
static let dateOutputFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    
    static let hourOutputFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()
    static let cardHourOutputFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
        
    }()

    static func formatHour(for date: Date, with timezoneIdentifier : String) -> String {
        if let timeZone = TimeZone(identifier: timezoneIdentifier) {
            hourOutputFormatter.timeZone = timeZone
            
            return hourOutputFormatter.string(from: date)
        }
        else{ return "--:--"}
        
    }
    static func date(from date: String)-> Date?{
        return inputDateFormatter.date(from: date)
    }
    static func formatDay(for date : Date) -> String {
        return dateOutputFormatter.string(from: date)
    }
    static func formatCurrentTime(for date: Date, with timezoneIdentifier : String)-> String{
        if let timeZone = TimeZone(identifier: timezoneIdentifier) {
            cardHourOutputFormatter.timeZone = timeZone
            
            return cardHourOutputFormatter.string(from: date)
        }
        else{ return "--:--"}

    }
    
  static  func formatTemperature(_ temperature: Double) -> String {
        String(format: "%.0f°", temperature)
    }
   static func celciusToFarenheit(_ celcius: Double) -> Double {
        return (celcius * 9/5) + 32
    
}
}
