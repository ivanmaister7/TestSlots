//
//  FooterBetAndSpinView.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

class FooterBetAndSpinView: UIView {
    lazy var playButton: UICustomGreenButton = {
        UICustomGreenButton(text: "spin", image: .largeCornerButtonBg)
    }()
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        
        addSubview(playButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        playButton.snp.remakeConstraints { view in
            view.bottom.top.trailing.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.15)
        }
    }
}
