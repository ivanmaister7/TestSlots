//
//  UIFooterBetAndSpinView.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

enum UIFooterBetAndSpinViewType {
    case version1, version2
}

////MARK: View Factory
//class UIFooterBetAndSpinViewFactory {
//    static func createUIFooterView(ofType type: UIFooterBetAndSpinViewType, playButtonText text: String) -> UIFooterBetAndSpinView {
//        let view = UIFooterBetAndSpinView(ofType: type)
//        view.spinButton.setTitle(text.uppercased(), for: .normal)
//        return view
//    }
//}

//MARK: View
class UIFooterBetAndSpinView: UIView, UIFooterBetAndSpinViewModelDelegate {
    let topOffset = 6.0
    let trailingSpinOffset = 84.0
    let topBalanceOffset = 48.0
    let spacingX = 8.0
    
    weak var spinDelegate: UIFooterSpinDelegate?
    var vm = UIFooterBetAndSpinViewModel()
    var type: UIFooterBetAndSpinViewType = .version1 {
        didSet {
            setupView()
        }
    }
    
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
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
     func setupView() {
        self.backgroundColor = .clear
        
        addSubview(spinButton)
        addSubview(balanceLabel)
        addSubview(betView)
        addSubview(winLabel)
        
        if type == .version1 {
            addSubview(maxBetButton)
            setupConstraintsVersion1()
        } else if type == .version2 {
            spinButton.setTitle("play".uppercased(), for: .normal)
            setupConstraintsVersion2()
        }
        
        reloadFooter()
        
        vm.delegate = self
    }
    
    private func setupConstraintsVersion1() {
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
    
    private func setupConstraintsVersion2() {
        spinButton.snp.remakeConstraints { view in
            view.bottom.equalToSuperview()
            view.trailing.equalToSuperview().offset(-trailingSpinOffset)
            view.width.equalToSuperview().multipliedBy(0.15)
            view.height.equalToSuperview().multipliedBy(0.15)
        }
        
        balanceLabel.snp.remakeConstraints { view in
            view.trailing.equalTo(spinButton.snp.trailing).offset(-topBalanceOffset)
            view.top.equalToSuperview().offset(4 * topOffset)
            view.width.equalToSuperview().multipliedBy(0.15)
            view.height.equalToSuperview().multipliedBy(0.1)
        }
        
        betView.snp.remakeConstraints { view in
            view.centerX.equalTo(winLabel.snp.centerX)
            view.bottom.equalTo(winLabel.snp.top).offset(-3 * topOffset)
            view.width.equalToSuperview().multipliedBy(0.25)
            view.height.equalTo(balanceLabel.snp.height)
        }
        
        winLabel.snp.remakeConstraints { view in
            view.bottom.equalToSuperview().offset(-3 * topOffset)
            view.width.equalToSuperview().multipliedBy(0.22)
            view.leading.equalToSuperview().offset(5 * topOffset)
            view.height.equalTo(balanceLabel.snp.height)
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
