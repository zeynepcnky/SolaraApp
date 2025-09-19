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
    @Binding var selectedUnit : Bool
    internal let onEdit: () -> Void
    
 
    var body: some View {
        GeometryReader { geometry in
            if isVisible {

                ZStack {
                    
                    Color.white.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isVisible = false
                            }
                        }
                }
                        
                    SettingsView(selectedUnit: $selectedUnit, onEdit: onEdit)
                        .frame(width: 250, height: 220)
                        .background(.regularMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .padding(.trailing, 60)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .position(x: geometry.size.width - 95, y: geometry.size.height - 650)
                        .animation(.spring(), value: isVisible)
                
           }
        }
        
    }
    
}


