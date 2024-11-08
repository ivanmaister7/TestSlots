//
//  SlotsModel.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import Foundation

protocol GameModel {
    associatedtype NewModel: GameModel
    static var defaultModel: [NewModel] { get }
    
    var key: ElementKey { get }
    var winMultiplicator: ElementValue { get }
}

extension GameModel {
    static var defaultWinningMap: [ElementKey: ElementValue] {
        Self.defaultModel.reduce(into: [ElementKey: ElementValue]()) { result, model in
            result[model.key] = model.winMultiplicator
        }
    }
}

struct SlotsModel: GameModel {
    let key: ElementKey
    let winMultiplicator: ElementValue
    let imageName: ElementImageName
    
    static let defaultModel = [
        SlotsModel(key: 0, winMultiplicator: 0.25 , imageName: "Item1"),
        SlotsModel(key: 1, winMultiplicator: 0.5  , imageName: "Item2"),
        SlotsModel(key: 2, winMultiplicator: 1    , imageName: "Item3"),
        SlotsModel(key: 3, winMultiplicator: 1.5  , imageName: "Item4"),
        SlotsModel(key: 4, winMultiplicator: 2    , imageName: "Item5"),
        SlotsModel(key: 5, winMultiplicator: 5    , imageName: "Item6"),
        SlotsModel(key: 6, winMultiplicator: 10   , imageName: "Item7"),
    ]
    
    static let defaultImageMap = defaultModel.reduce(into: [ElementKey: ElementImageName]()) { result, model in
        result[model.key] = model.imageName
    }
}
