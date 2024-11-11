//
//  PlinkoSceneDelegate.swift
//  TestSlots
//
//  Created by ivan on 11.11.2024.
//

import Foundation

typealias Bucket = ElementKey

protocol PlinkoSceneDelegate: MiniGameSceneDelegate {
    func setFinalBucket(_ bucket: Bucket)
}
