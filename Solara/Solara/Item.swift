//
//  Item.swift
//  Solara
//
//  Created by Zeynep Cankaya on 17.07.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
