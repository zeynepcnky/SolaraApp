//
//  CardView.swift
//  Solara
//
//  Created by Zeynep Cankaya on 23.07.2025.
//

import SwiftUI
import SwiftData

struct CardView : View {

    @State var city : String
    @State var temperature : Double
    @State var formatter = WeatherFormatter()
    
    var body: some View {
        
HStack{
            Image(systemName: "sun.max")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
                .padding(.leading,35)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 4){
               
                Text(city)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                
                Text("\(formatter.formatTemperature(temperature))")
                    .font(.system(size: 48, weight: .medium))
                    .foregroundColor(.white)
                
            }
            .padding(.trailing, 35)
            
        }  
            .frame(width: 350, height: 200, alignment: .trailing)
            .background(
                RoundedRectangle(cornerRadius: 48)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing )))
            
        }
    }


