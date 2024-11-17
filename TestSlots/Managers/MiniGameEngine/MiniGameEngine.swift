//
//  MiniGameEngine.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

typealias WinSum = Int
typealias ElementKey = Int
typealias ElementValue = Double
typealias ElementImageName = String

protocol MiniGameEngine {
    associatedtype Model: GameModel
    associatedtype ResultType
    
    var winningMap: [ElementKey: ElementValue] { get }
    
    func playRound()
    func checkResults()
    func getFinalConfiguration() -> ResultType
}

extension MiniGameEngine {
    var winningMap: [ElementKey: ElementValue] {
        get {
            Model.defaultWinningMap
        }
    }
    
    func makeBalanceChangesBeforeGame() {
        guard let balance = StorageManager.defaults.getBalance(),
              let bet = StorageManager.defaults.getLastBet() else { fatalError("Balance are not available!") }
        StorageManager.defaults.saveBalance(value: balance - bet)
    }
}
