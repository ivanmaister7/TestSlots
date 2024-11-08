//
//  RouletteViewControllerExtension.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

extension RouletteViewController: RouletteSceneDelegate {
    func onFinishAnimation() {
        rouletteGameEngine.checkResults()
        rouletteGameEngine.makeBalanceChangesAfterGame()
        footerView.reloadFooter()
        footerView.toggleDisableButtons()
#warning("if win show alert")
    }
    
    func getFinalAngle() -> Angle {
        rouletteGameEngine.getFinalConfiguration()
    }
}

extension RouletteViewController: UIFooterSpinDelegate {
    func onSpinAction() {
        rouletteGameEngine.playRound()
        rouletteScene?.spinAction()
        footerView.reloadFooter()
    }
}
