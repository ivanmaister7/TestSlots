//
//  RouletteGameEngine.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

class RouletteGameEngine: MiniGameEngine {
    typealias Model = RouletteModel
    var gameAngleKey: ElementKey = 0
    
    func playRound() {
        makeBalanceChangesBeforeGame()
        gameAngleKey = winningMap.keys.randomElement() ?? 0
    }
    
    func checkResults() {
        if let bet = StorageManager.defaults.getLastBet() {
            //my custom winnig formula
            let winValue: Int = Int(winningMap[gameAngleKey] ?? 1)
            let win = winValue < 1000 ? bet * winValue : winValue
            StorageManager.defaults.saveLastWinRoulette(value: win)
        }
    }
    
    func getFinalConfiguration() -> Angle {
        return Model.defaultAngleMap[gameAngleKey] ?? 0.0
    }
    
    
    func makeBalanceChangesAfterGame() {
        guard let balance = StorageManager.defaults.getBalance(),
              let win = StorageManager.defaults.getLastWin(.roulette) else { fatalError("Balance and Last Win are not available!") }
        StorageManager.defaults.saveBalance(value: balance + win)
    }
}
