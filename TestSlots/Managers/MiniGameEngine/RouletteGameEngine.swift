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
            StorageManager.defaults.saveLastWin(value: win)
        }
    }
    
    func getFinalConfiguration() -> Angle {
        return Model.defaultAngleMap[gameAngleKey] ?? 0.0
    }
}
