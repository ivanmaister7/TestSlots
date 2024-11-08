//
//  SlotMachineSceneDelegate.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

protocol MiniGameSceneDelegate: AnyObject {
    func onFinishAnimation()
}

protocol SlotMachineSceneDelegate: MiniGameSceneDelegate {
    func getCurrentKeysPositions() -> [[ElementKey]]
}
