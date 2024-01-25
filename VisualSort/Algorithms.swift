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
    
    mutating func insertionSort(startPosition: Int) -> Int {
        guard startPosition < count else { return startPosition}
        
        let itemToPlace = self[startPosition]
        var currentItemIndex = startPosition
        
        while currentItemIndex > 0 && itemToPlace < self[currentItemIndex - 1] {
            self[currentItemIndex] = self[currentItemIndex - 1]
            currentItemIndex -= 1
            
        }
        self[currentItemIndex] =  itemToPlace
        return startPosition + 1
    }
    
    mutating func quickSort() {
        guard count > 1 else { return }
        
        let pivot =  self[Int.random(in: 0..<count)]
        var before = self.filter { $0 < pivot }
        var after = self.filter { $0 > pivot }
        let equal = self.filter { $0 == pivot }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            before.quickSort()
            after.quickSort()
        }
        
        self = before + equal + after
    }
}
