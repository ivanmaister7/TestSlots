//
//  SlotMachineSceneConfiguration.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

struct SlotMachineSceneConfiguration {
    let rows: Int
    let columns: Int
    let rowSpacing: Double
    let columnSpacing: Double
    
    init(rows: Int = 3, columns: Int = 5, rowSpacing: Double = 0.0, columnSpacing: Double = 0.0) {
        self.rows = rows
        self.columns = columns
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
    }
}
