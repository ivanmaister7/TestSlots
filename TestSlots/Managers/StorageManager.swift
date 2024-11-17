//
//  StorageManager.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import Foundation

class StorageManager {
    private let initialBalance = 10_000
    private let initialLastBet = 1_000
    private let initialLastWin = 0
    private let initialIsSoundOn = true
    
    static let defaults = StorageManager()
    private let def: UserDefaults
    
    private init() {
        def = UserDefaults.standard
        
        //make initial values when first launch in game
        if self.getBalance() == nil { saveBalance(value: initialBalance) }
        if self.getLastBet() == nil { saveLastBet(value: initialLastBet) }
        if self.getLastWin(.slots) == nil { saveLastWinSlots(value: initialLastWin) }
        if self.getLastWin(.roulette) == nil { saveLastWinRoulette(value: initialLastWin) }
        if self.getLastWin(.plinko) == nil { saveLastWinPlinko(value: initialLastWin) }
        if self.getIsSoundOn() == nil { setValue(forKey: .isSoundOn, value: initialIsSoundOn) }
    }
    
    private func getValue(forKey key: StorageKeys) -> Any? {
        return def.object(forKey: key.rawValue)
    }
    
    private func setValue(forKey key: StorageKeys, value: Any) {
        def.set(value, forKey: key.rawValue)
    }
    
    func setInitialValues() {
        saveBalance(value: initialBalance)
        saveLastBet(value: initialLastBet)
        saveLastWinSlots(value: initialLastWin)
        saveLastWinRoulette(value: initialLastWin)
        saveLastWinPlinko(value: initialLastWin)
    }
    
    func saveBalance(value: Int) {
        setValue(forKey: .balance, value: value > 0 ? value : 0)
    }
    
    func getBalance() -> Int? {
        getValue(forKey: .balance) as? Int
    }
    
    func saveLastBet(value: Int) {
        setValue(forKey: .lastBet, value: value)
    }
    
    func getLastBet() -> Int? {
        getValue(forKey: .lastBet) as? Int
    }
    
    func saveLastWinSlots(value: Int) {
        setValue(forKey: .lastWinSlots, value: value)
    }
    
    func saveLastWinRoulette(value: Int) {
        setValue(forKey: .lastWinRoulette, value: value)
    }
    
    func saveLastWinPlinko(value: Int) {
        setValue(forKey: .lastWinPlinko, value: value)
    }
    
    func getLastWin(_ gameType: UIFooterBetAndSpinViewGameType) -> Int? {
        let key: StorageKeys = switch gameType {
        case .slots:
             .lastWinSlots
        case .roulette:
             .lastWinRoulette
        case .plinko:
             .lastWinPlinko
        default:
             .lastWinSlots
        }
        
        return getValue(forKey: key) as? Int
    }
    
    func saveIsSoundOn(value: Bool) {
        if getIsSoundOn() ?? false != value {
            value ? SoundManager.shared.playSound() : SoundManager.shared.stopSound()
        }
        
        setValue(forKey: .isSoundOn, value: value)
    }
    
    func getIsSoundOn() -> Bool? {
        getValue(forKey: .isSoundOn) as? Bool
    }
}

enum StorageKeys: String {
    case balance
    case lastBet
    case lastWinSlots
    case lastWinRoulette
    case lastWinPlinko
    case isSoundOn
}
