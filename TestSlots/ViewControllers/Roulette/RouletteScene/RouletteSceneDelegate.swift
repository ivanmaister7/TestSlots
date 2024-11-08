//
//  RouletteSceneDelegate.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

typealias Angle = Double

protocol RouletteSceneDelegate: MiniGameSceneDelegate {
    func getFinalAngle() -> Angle
}
