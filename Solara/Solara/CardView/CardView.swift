//
//  CardView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CardView : View {
    
    var city : String
    var temperature : Double
    var formatter = WeatherFormatter()
    let weatherCode : Int
    @Binding var selectedUnit : Bool
    
    var displayedTemp : Double {
        selectedUnit ? formatter.celciusToFarenheit(temperature) : temperature
    }
    
    
    var body: some View {
  
            HStack{
                let weatherIcon = WeatherIcon(code: weatherCode)
                
                Image(weatherIcon.assetName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(.leading,35)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4){
                    
                    Text(city)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("\(formatter.formatTemperature(displayedTemp))")
                        .font(.system(size: 48, weight: .medium))
                        .foregroundColor(.white)
                    
                }
                .padding(.trailing, 35)
            }
            
            
            .frame(width: 350, height: 200, alignment: .center)
            
            .background(
                RoundedRectangle(cornerSize: .init(width: 35, height: 35))
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing )))
            
            
            
            
        

        
    }
}
