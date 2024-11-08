//
//  UIBetView.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import UIKit

class UIBetView: UIView {
    private var minusAction: () -> () = {}
    private var plusAction: () -> () = {}
    
    lazy var betLabel: UITwoRowLabel = {
        UITwoRowLabel()
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .minusBtn), for: .normal)
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .plusBtn), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        
        addSubview(betLabel)
        addSubview(minusButton)
        addSubview(plusButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        betLabel.snp.remakeConstraints { view in
            view.bottom.top.equalToSuperview()
            view.leading.equalTo(minusButton.snp.trailing).offset(8)
            view.trailing.equalTo(plusButton.snp.leading).offset(-8)
        }
        
        minusButton.snp.remakeConstraints { view in
            view.leading.bottom.top.equalToSuperview()
            view.width.equalTo(minusButton.snp.height).multipliedBy(0.75)
        }
        
        plusButton.snp.remakeConstraints { view in
            view.trailing.bottom.top.equalToSuperview()
            view.width.equalTo(plusButton.snp.height).multipliedBy(0.75)
        }
    }
    func toggleDisableButtons() {
        plusButton.isEnabled.toggle()
        minusButton.isEnabled.toggle()
    }
    
    func addMinusAction(minusAction: @escaping () -> ()) {
        self.minusAction = minusAction
        self.minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
    }
    
    @objc private func minusButtonAction() {
        self.minusAction()
    }
    
    
    func addPlusAction(plusAction: @escaping () -> ()) {
        self.plusAction = plusAction
        self.plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
    }
    
    @objc private func plusButtonAction() {
        self.plusAction()
    }
    
    func setText(primary: String, secondary: String) {
        self.betLabel.setText(primary: primary, secondary: secondary)
    }
}

