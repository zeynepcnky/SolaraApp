//
//  SettingsOverlay.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.09.2025.
//
import Foundation
import SwiftUI

struct SettingsOverlay: View {
    @Binding var isVisible: Bool
   
    
    var body: some View {
        GeometryReader { geometry in
            if isVisible {
                ZStack {
                    Color.white.opacity(0.5)
                        .ignoresSafeArea()
                        
                        
                    
                    SettingsView()
                        .frame(width: 250, height: 350)
                        .background(.ultraThickMaterial)
                    
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .position(x: geometry.size.width + 50, y: geometry.size.height - 250)
                        .transition(.opacity)
                }
           }
        }
    }
}


