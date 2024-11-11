//
//  PlinkoModel.swift
//  TestSlots
//
//  Created by ivan on 11.11.2024.
//

import Foundation

struct PlinkoModel: GameModel {
    let key: ElementKey
    let winMultiplicator: ElementValue
    let imageName: ElementImageName
    
    static let defaultModel = [
        PlinkoModel(key: 0, winMultiplicator: 5.0, imageName: "bucket1"),
        PlinkoModel(key: 1, winMultiplicator: 2.0, imageName: "bucket2"),
        PlinkoModel(key: 2, winMultiplicator: 1.0, imageName: "bucket3"),
        PlinkoModel(key: 3, winMultiplicator: 0.5, imageName: "bucket4"),
        PlinkoModel(key: 4, winMultiplicator: 1.0, imageName: "bucket5"),
        PlinkoModel(key: 5, winMultiplicator: 2.0, imageName: "bucket6"),
        PlinkoModel(key: 6, winMultiplicator: 5.0, imageName: "bucket7")
    ]
    
    static let defaultImageMap = defaultModel.reduce(into: [ElementKey: ElementImageName]()) { result, model in
        result[model.key] = model.imageName
    }
}
