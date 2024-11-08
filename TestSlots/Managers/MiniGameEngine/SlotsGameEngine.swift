//
//  SlotsGameEngine.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import Foundation

class SlotsGameEngine: MiniGameEngine {
    typealias Model = SlotsModel
    
    private var rows: Int
    private var columns: Int
    private var gameMatrix: [[ElementKey]]
    
    init(rows: Int, columns: Int) {
        self.rows = (rows % 2 == 1 ? rows : rows - 1)
        self.columns = columns
        self.gameMatrix = Array(repeating: Array(repeating: 0, count: columns), count: rows)
        
        fillGameMatrix()
    }
    
    func playRound() {
        makeBalanceChangesBeforeGame()
        fillGameMatrix()
    }
    
    func getFinalConfiguration() -> [[ElementKey]] {
        return gameMatrix
    }
    
    func checkResults() {
        let middleRow = rows / 2
        let (mostFrequentElement, count) = gameMatrix[middleRow].mostFrequentElement() ?? (0,0)
        if let bet = StorageManager.defaults.getLastBet() {
            //my custom winnig formula
            let win = bet * Int((winningMap[mostFrequentElement] ?? 1.0)) * count / columns
            StorageManager.defaults.saveLastWin(value: win)
        }
    }
    
    
    private func fillGameMatrix() {
        for row in 0..<rows {
            for col in 0..<columns {
                self.gameMatrix[row][col] = winningMap.keys.randomElement() ?? 0
            }
        }
    }
}
