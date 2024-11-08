//
//  FooterBetAndSpinViewModel.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

protocol UIFooterBetAndSpinViewModelDelegate: AnyObject {
    func reloadFooter()
}

class UIFooterBetAndSpinViewModel {
    let betStep = 1000
    
    weak var delegate: UIFooterBetAndSpinViewModelDelegate?
    
    var balance: Int {
        set {
            StorageManager.defaults.saveBalance(value: newValue)
        }
        get {
            StorageManager.defaults.getBalance() ?? 0
        }
    }
    
    var bet: Int {
        set {
            if newValue <= balance && newValue > 0 {
                StorageManager.defaults.saveLastBet(value: newValue)
                delegate?.reloadFooter()
            }
        }
        get {
            let lastBet = StorageManager.defaults.getLastBet() ?? betStep
            return lastBet < balance ? lastBet : balance
        }
    }
    
    var win: Int {
        set { }
        get {
            StorageManager.defaults.getLastWin() ?? 0
        }
    }
    
    func setMaxBet() {
        bet = balance
    }
    
    func plusAction() {
        bet += betStep
    }
    
    func minusAction() {
        bet -= betStep
    }
}
