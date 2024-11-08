//
//  UIFooterBetAndSpinView.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

class UIFooterBetAndSpinView: UIView, UIFooterBetAndSpinViewModelDelegate {
    let topOffset = 6.0
    let spacingX = 8.0
    
    weak var spinDelegate: UIFooterSpinDelegate?
    var vm = UIFooterBetAndSpinViewModel()
    
    //MARK: UI
    
    lazy var balanceLabel: UIBalanceLabel = {
        UIBalanceLabel()
    }()
    
    lazy var winLabel: UITwoRowLabel = {
        UITwoRowLabel()
    }()
    
    lazy var maxBetButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(resource: .maxBetBtn), for: .normal)
        button.addTarget(self, action: #selector(maxBetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var spinButton: UICustomGreenButton = {
        let button = UICustomGreenButton(text: "spin", image: .largeCornerButtonBg)
        button.addTarget(self, action: #selector(spinButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var betView: UIBetView = {
        let view = UIBetView()
        view.addPlusAction(plusAction: { [weak self] in self?.vm.plusAction() })
        view.addMinusAction(minusAction: { [weak self] in self?.vm.minusAction() })
        return view
    }()
    
    
    //MARK: Lifecycle
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        
        addSubview(spinButton)
        addSubview(balanceLabel)
        addSubview(betView)
        addSubview(winLabel)
        addSubview(maxBetButton)
        
        setupConstraints()
        reloadFooter()
        
        vm.delegate = self
    }
    
    private func setupConstraints() {
        spinButton.snp.remakeConstraints { view in
            view.bottom.top.trailing.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.15)
        }
        
        balanceLabel.snp.remakeConstraints { view in
            view.bottom.leading.equalToSuperview()
            view.top.equalToSuperview().offset(topOffset)
            view.width.equalToSuperview().multipliedBy(0.15)
        }
        
        betView.snp.remakeConstraints { view in
            view.bottom.equalToSuperview()
            view.top.equalToSuperview().offset(topOffset)
            view.leading.equalTo(balanceLabel.snp.trailing).offset(2 * spacingX)
            view.width.equalToSuperview().multipliedBy(0.25)
        }
        
        winLabel.snp.remakeConstraints { view in
            view.bottom.equalToSuperview()
            view.top.equalToSuperview().offset(topOffset)
            view.leading.equalTo(betView.snp.trailing).offset(spacingX)
            view.trailing.equalTo(maxBetButton.snp.leading).offset(-spacingX)
        }
        
        maxBetButton.snp.remakeConstraints { view in
            view.bottom.equalToSuperview()
            view.top.equalToSuperview().offset(topOffset)
            view.trailing.equalTo(spinButton.snp.leading).offset(-spacingX)
            view.width.equalTo(maxBetButton.snp.height)
        }
    }
    
    func reloadFooter() {
        balanceLabel.setBalance("\(vm.balance)")
        betView.setText(primary: "\(vm.bet)", secondary: "total bet")
        winLabel.setText(primary: "\(vm.win)", secondary: "win")
    }
    
    func toggleDisableButtons() {
        spinButton.isEnabled.toggle()
        maxBetButton.isEnabled.toggle()
        betView.toggleDisableButtons()
    }
    
    @objc private func maxBetButtonTapped() {
        self.vm.setMaxBet()
    }
    
    @objc private func spinButtonTapped() {
        self.spinDelegate?.onSpinAction()
        self.toggleDisableButtons()
    }
}
