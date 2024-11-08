//
//  ArrayExtension.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import Foundation

extension Array where Element: Hashable {
    func mostFrequentElement() -> (Element, Int)? {
        guard !isEmpty else { return nil }
        
        var counts: [Element: Int] = [:]
        for element in self {
            counts[element, default: 0] += 1
        }
        
        if let resultElem = counts.max(by: { $0.value < $1.value }) {
            return (resultElem.key, resultElem.value)
        }
        return nil
    }
}
