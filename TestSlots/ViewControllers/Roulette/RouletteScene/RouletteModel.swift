//
//  RouletteModel.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

struct RouletteModel: GameModel {
    let key: ElementKey
    let winMultiplicator: ElementValue
    let angle: Angle
    
    static let defaultModel = [
        RouletteModel(key: 0,  winMultiplicator: 10.0, angle: .pi_2 * (16 / 16)),
        RouletteModel(key: 1,  winMultiplicator: 1000, angle: .pi_2 * (15 / 16)),
        RouletteModel(key: 2,  winMultiplicator: 2.0 , angle: .pi_2 * (14 / 16)),
        RouletteModel(key: 3,  winMultiplicator: 3000, angle: .pi_2 * (13 / 16)),
        RouletteModel(key: 4,  winMultiplicator: 0.0 , angle: .pi_2 * (12 / 16)),
        RouletteModel(key: 5,  winMultiplicator: 5000, angle: .pi_2 * (11 / 16)),
        RouletteModel(key: 6,  winMultiplicator: 8000, angle: .pi_2 * (10 / 16)),
        RouletteModel(key: 7,  winMultiplicator: 7000, angle: .pi_2 * (9  / 16)),
        RouletteModel(key: 8,  winMultiplicator: 10.0, angle: .pi_2 * (8  / 16)),
        RouletteModel(key: 9,  winMultiplicator: 9000, angle: .pi_2 * (7  / 16)),
        RouletteModel(key: 10, winMultiplicator: 2.0 , angle: .pi_2 * (6  / 16)),
        RouletteModel(key: 11, winMultiplicator: 7000, angle: .pi_2 * (5  / 16)),
        RouletteModel(key: 12, winMultiplicator: 0.0 , angle: .pi_2 * (4  / 16)),
        RouletteModel(key: 13, winMultiplicator: 6000, angle: .pi_2 * (3  / 16)),
        RouletteModel(key: 14, winMultiplicator: 4000, angle: .pi_2 * (2  / 16)),
        RouletteModel(key: 15, winMultiplicator: 2000, angle: .pi_2 * (1  / 16))
    ]
    
    static let defaultAngleMap = defaultModel.reduce(into: [ElementKey: Angle]()) { result, model in
        result[model.key] = model.angle
    }
}
