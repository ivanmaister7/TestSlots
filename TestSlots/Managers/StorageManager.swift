//
//  StorageManager.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import Foundation

class StorageManager {
    static let defaults = StorageManager()
    private let def: UserDefaults
    
    private init() {
        def = UserDefaults.standard
        
        //make initial values when first launch in game
        if self.getBalance() == nil { saveBalance(value: 10_000) }
        if self.getLastBet() == nil { saveLastBet(value: 1_000) }
        if self.getLastWin() == nil { saveLastWin(value: 0) }
    }
    
    private func getValue(forKey key: StorageKeys) -> Any? {
        return def.object(forKey: key.rawValue)
    }
    
    private func setValue(forKey key: StorageKeys, value: Any) {
        def.set(value, forKey: key.rawValue)
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
    
    func saveLastWin(value: Int) {
        setValue(forKey: .lastWin, value: value)
    }
    
    func getLastWin() -> Int? {
        getValue(forKey: .lastWin) as? Int
    }
}

enum StorageKeys: String {
    case balance
    case lastBet
    case lastWin
}
