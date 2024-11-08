//
//  UIBalanceLabel.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import UIKit

class UIBalanceLabel: UIView {
    lazy var balanceBg: UIImageView = {
        UIImageView(image: UIImage(resource: .balanceBg))
    }()
    
    lazy var balanceCoin: UIImageView = {
        UIImageView(image: UIImage(resource: .balanceCoinIcon))
    }()
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.font = .getKohSantepheap700(size: 20)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
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
        
        addSubview(balanceBg)
        addSubview(balanceCoin)
        addSubview(balanceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        balanceBg.snp.remakeConstraints { view in
            view.bottom.top.trailing.leading.equalToSuperview()
        }
        
        balanceCoin.snp.remakeConstraints { view in
            view.width.equalTo(balanceCoin.snp.height)
            view.centerY.equalToSuperview()
            view.leading.equalToSuperview().offset(8)
            view.height.equalToSuperview().multipliedBy(0.65)
        }
        
        balanceLabel.snp.remakeConstraints { view in
            view.centerY.equalToSuperview()
            view.leading.equalTo(balanceCoin.snp.trailing).offset(8)
            view.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func setBalance(_ balance: String) {
        self.balanceLabel.text = balance
    }
}
