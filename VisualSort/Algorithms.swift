//
//  Algorithms.swift
//  VisualSort
//
//  Created by HubertMac on 25/01/2024.
//

import Foundation

extension Array where Element: Comparable {
    mutating func bubbleSort() {
        for index in 0..<count - 1 {
            if self[index] > self[index + 1] {
                swapAt(index, index + 1)
                
            }
        }
    }
}
