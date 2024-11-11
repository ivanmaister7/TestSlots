//
//  PlinkoViewControllerExtension.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

extension PlinkoViewController: PlinkoSceneDelegate {
    func onFinishAnimation() {
        plinkoGameEngine.checkResults()
        plinkoGameEngine.makeBalanceChangesAfterGame()
        footerView.reloadFooter()
        footerView.toggleDisableButtons()
        if let win = StorageManager.defaults.getLastWin(), win > 1 {
            present(YouWinAlertViewController(bg: .youWinBgPlinko), animated: false)
        }
    }
    
    func setFinalBucket(_ bucket: ElementKey) {
        plinkoGameEngine.setFinalBucket(bucket)
    }
}

extension PlinkoViewController: UIFooterSpinDelegate {
    func onSpinAction() {
        plinkoGameEngine.playRound()
        plinkoScene?.dropBall()
        footerView.reloadFooter()
    }
}
