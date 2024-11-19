//
//  SlotsViewControllerExtension.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

extension SlotsViewController: SlotMachineSceneDelegate {
    func onFinishAnimation() {
        slotsGameEngine.checkResults()
        slotsGameEngine.makeBalanceChangesAfterGame()
        footerView.reloadFooter()
        footerView.toggleDisableButtons()
        
        if let win = StorageManager.defaults.getLastWin(.slots), win > 1 {
            present(YouWinAlertViewController(bg: .youWinBgSlots), animated: false)
        }
    }
    
    func getCurrentKeysPositions() -> [[ElementKey]] {
        slotsGameEngine.getFinalConfiguration()
    }
}

extension SlotsViewController: UIFooterSpinDelegate {
    func onSpinAction() {
        slotsGameEngine.playRound()
        slotMachineScene?.spinSlots()
        footerView.reloadFooter()
    }
    
    func onEmptyBalance() {
        present(YouWinAlertViewController(bg: .youWinBgSlots, type: .lose), animated: false)
    }
}
