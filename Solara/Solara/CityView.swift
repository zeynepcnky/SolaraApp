//
//  CityView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CityView: View {
    
    
    @State var viewModel : WeatherViewModel
    var city : String?
    var onAdd : () -> Void
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text(city ?? "")
                    .font(.title2)
                    .bold()
                    .padding()
                
                Image(systemName: "sun.max")
                    .font(.system(size: 100))
                    .foregroundColor(.yellow)
                    .padding()
                
                let temp = viewModel.weather
                
                let current = temp?.current.temperature
                Text(String(format: "%.0f°", current ?? "0.0" ))
                    .font(.system(size: 45, weight: .bold))
                
                Text("Weather description might be here")
                    .font(.caption)
                HStack{
                    
                    let maxTemp = temp?.daily.temperatureMax.first
                    Text("Max:\(String(format:"%.0f°", maxTemp ?? 0.0 ))")
                    
                    
                    let minTemp = temp?.daily.temperatureMin.first
                    Text("Min: \(String(format:"%.0f°", minTemp ?? 0.0 ))")
                    
                }
                .font(.system(size: 14))
                
                Divider()
                
                Text("7-Day Forecast")
                    .font(.headline)
                    .padding(.top, 8)
                
                if let forecasts = temp?.daily {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 12) {
                            
                            ForEach(0..<forecasts.time.count, id:\.self){ index in
                                VStack(spacing: 4){
                                    if let date = dateFromString(forecasts.time[index]){
                                        Text(dateFormatter.string(from: date))
                                            .frame(width: 60, alignment: .leading)
                                        
                                        
                                        Image(systemName: "sun.max")
                                        
                                        Text("🌡️\(String(format: "%.0f°", forecasts.temperatureMax[index]))")
                                            .foregroundColor(.red)
                                        Text("🌡️\(String(format: "%.0f°", forecasts.temperatureMin[index]))")
                                            .foregroundColor(.red)
                                    }
                                }
                                .frame(width: 80, height: 100)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
                    .navigationBarItems(
                        leading: Button("Cancel") { dismiss() },
                        trailing: Button("Add") {
                            onAdd()
                            dismiss()
                        }
                    )
                    .frame(alignment: .top)
                
            }
    }
    func dateFromString(_ string : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: string)
    }
    
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
}


#Preview {
   
}
