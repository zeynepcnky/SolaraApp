//
//  WeatherFormatter.swift
//  Solara
//
//  Created by Zeynep Cankaya on 5.09.2025.
//
import Foundation



struct WeatherFormatter {
    
    static let inputDateFormatter : ISO8601DateFormatter = {
       let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return formatter
    }()
    
    static let dateOutputFormatter : DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
    }()
    
    static let inputHourFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    


    static func formatHour(for date: Date, with timezoneIdentifier : String) -> String {
        guard let timeZone = TimeZone(identifier: timezoneIdentifier) else {
            return "--:--"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        
        return formatter.string(from: date)
        
    }
    
    static func date(from date: String)-> Date?{
        return inputHourFormatter.date(from: date) ?? inputDateFormatter.date(from: date)
    }
    
    static func formatDay(for date : Date) -> String {
        return dateOutputFormatter.string(from: date)
    }
    
    static func formatCurrentTime(for date: Date, with timezoneIdentifier : String)-> String{
        guard let timeZone = TimeZone(identifier: timezoneIdentifier) else {
            return "--:--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = timeZone
        
        return formatter.string(from: date)
        }
    
  static  func formatTemperature(_ temperature: Double) -> String {
        String(format: "%.0f°", temperature)
    }
    
   static func celciusToFarenheit(_ celcius: Double) -> Double {
        return (celcius * 9/5) + 32
    }
}
extension DateFormatter: DateParsing {}
extension ISO8601DateFormatter: DateParsing {}
