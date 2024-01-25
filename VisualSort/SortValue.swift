//
//  SortValue.swift
//  VisualSort
//
//  Created by HubertMac on 25/01/2024.
//

import SwiftUI


struct SortValue: Comparable, Identifiable {
    var id: Int
    
    var color: Color {
        Color(hue: Double(id) / 100, saturation: 1, brightness: 1)
    }
    
    static func <(lhs: SortValue, rhs: SortValue) -> Bool {
        lhs.id < rhs.id
    }
}
