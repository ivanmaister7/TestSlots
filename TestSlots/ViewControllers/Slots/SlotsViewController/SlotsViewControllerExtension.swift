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
#warning("if win show alert")
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
}
