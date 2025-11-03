//
//  SettingsOverlay.swift
//  Solara
//
//  Created by Zeynep Cankaya on 8.09.2025.
//

import SwiftUI

struct SettingsOverlay: View {
    @Binding var isVisible: Bool
    @Binding var selectedUnit: Bool
    
    let onEdit: () -> Void

    var body: some View {
        
        if isVisible {
            
            ZStack(alignment: .topTrailing) {
                
                
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isVisible = false
                        }
                    }
                
                
                SettingsView(selectedUnit: $selectedUnit, onEdit: onEdit)
                    .frame(width: 250, height: 220)
                    .background(.regularMaterial)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    .zIndex(1)
                    .padding(.top, -5)
                    .padding(.trailing, 20)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
           
            .animation(.spring(), value: isVisible)
        }
    }
}


