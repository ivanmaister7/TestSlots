//
//  MainMenuViewController.swift
//  TestSlots
//
//  Created by ivan on 05.11.2024.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var gamesStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSettingsButton()
        
        setupGameViews()
    }
    
    private func setupGameViews() {
        let models = createGameModels()
        models.map { MenuGameViewFactory.createGameView(with: $0) }
            .forEach { gamesStackView.addArrangedSubview($0) }
    }
    
    private func createGameModels() -> [MenuGameViewModel] {
        return [
            MenuGameViewModel(gameName: "Slots",
                              gameIcon: .gameSlotsIcon,
                              onClickAction: { [weak self] in
                                  self?.navigationController?.pushViewController(SlotsViewController(), animated: true)
                              }),
            MenuGameViewModel(gameName: "Roulette",
                              gameIcon: .gameRouletteIcon,
                              onClickAction: { [weak self] in
                                  self?.navigationController?.pushViewController(RouletteViewController(), animated: true)
                              }),
            MenuGameViewModel(gameName: "Plinko",
                              gameIcon: .gamePlinkoIcon,
                              onClickAction: { [weak self] in
                                  self?.navigationController?.pushViewController(UIViewController(), animated: true)
                              })
        ]
    }
}
