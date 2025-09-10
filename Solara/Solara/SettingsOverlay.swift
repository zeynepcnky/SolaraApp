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

                    Color.white.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isVisible = false
                            }
                        }
              
                        
                        SettingsView()
                        .frame(width: 250, height: 180)
                        .background(.regularMaterial)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .padding(.trailing, 60)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .position(x: geometry.size.width + 50, y: geometry.size.height - 350)
                        .animation(.spring(), value: isVisible)
                }
           }
        }
    }
}


