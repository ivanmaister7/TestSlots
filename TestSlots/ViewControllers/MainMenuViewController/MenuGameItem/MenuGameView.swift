//
//  MenuGameView.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit
import SnapKit

//MARK: View Factory
class MenuGameViewFactory {
    static func createGameView(with model: MenuGameViewModel) -> MenuGameView {
        let view = MenuGameView()
        view.setUp(with: model)
        return view
    }
}

//MARK: View
class MenuGameView: UIView {
    
    let playButtonTitle = "play now"
    var model: MenuGameViewModel?
    
    lazy var gameBackgroundView: UIImageView = {
        UIImageView(image: UIImage(resource: .gameViewBg))
    }()
    
    lazy var gameIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.applyShadow(color: UIColor.menuIconShadow, opacity: 5.0, radius: 7.0)
        return imageView
    }()
    
    lazy var gameNameLabel: UILabel = {
        var label = UILabel()
        label.font = .getSuranna400(size: 28)
        label.textAlignment = .center
        label.textColor = .menuGameName
        return label
    }()
    
    lazy var playButton: UICustomGreenButton = {
        UICustomGreenButton(text: playButtonTitle)
    }()
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        addSubview(gameBackgroundView)
        addSubview(playButton)
        gameBackgroundView.addSubview(gameIconView)
        gameBackgroundView.addSubview(gameNameLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        gameBackgroundView.snp.remakeConstraints { view in
            view.top.leading.trailing.equalToSuperview()
            view.bottom.equalTo(playButton.snp.top).offset(-16)
            view.height.equalTo(playButton).multipliedBy(3)
        }
        
        gameIconView.snp.remakeConstraints { view in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.75)
        }
        
        gameNameLabel.snp.remakeConstraints { view in
            view.bottom.leading.trailing.equalToSuperview()
            view.top.equalTo(gameIconView.snp.bottom)
        }
        
        playButton.snp.remakeConstraints { view in
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setUp(with model: MenuGameViewModel) {
        self.model = model
        gameNameLabel.text = model.gameName.capitalized
        gameIconView.image = UIImage(resource: model.gameIcon)
        playButton.addTarget(self, action: #selector(onClickAction), for: .touchUpInside)
    }
    
    @objc private func onClickAction() {
        if let model { model.onClickAction() } else { print("MenuGameView: model is nil!") }
    }
}
