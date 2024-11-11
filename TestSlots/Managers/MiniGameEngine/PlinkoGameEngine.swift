//
//  PlinkoGameEngine.swift
//  TestSlots
//
//  Created by ivan on 11.11.2024.
//

import Foundation

class PlinkoGameEngine: MiniGameEngine {
    typealias Model = PlinkoModel
    var finalBucket: Bucket = 0
    
    func playRound() {
        makeBalanceChangesBeforeGame()
    }
    
    func checkResults() {
        if let bet = StorageManager.defaults.getLastBet() {
            //my custom winnig formula
            let winValue = winningMap[finalBucket] ?? 1
            let win = Double(bet) * winValue
            StorageManager.defaults.saveLastWin(value: Int(win))
        }
    }
    func setFinalBucket(_ bucket: Bucket) {
        self.finalBucket = bucket
    }
    
    func getFinalConfiguration() -> Bucket {
        finalBucket
    }
}
