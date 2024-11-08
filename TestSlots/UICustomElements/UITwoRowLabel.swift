//
//  UITwoRowLabel.swift
//  TestSlots
//
//  Created by ivan on 07.11.2024.
//

import UIKit

class UITwoRowLabel: UIView {
    lazy var labelBg: UIImageView = {
        UIImageView(image: UIImage(resource: .blueLabelBg))
    }()
    
    lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.font = .getInter700(size: 15)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = .getInter700(size: 11)
        label.textColor = .white.withAlphaComponent(0.3)
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
        
        addSubview(labelBg)
        addSubview(secondaryLabel)
        addSubview(primaryLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        labelBg.snp.remakeConstraints { view in
            view.bottom.top.trailing.leading.equalToSuperview()
        }
        
        secondaryLabel.snp.remakeConstraints { view in
            view.leading.trailing.equalToSuperview()
            view.top.equalToSuperview().offset(2)
            view.height.equalToSuperview().multipliedBy(0.45)
        }
        
        primaryLabel.snp.remakeConstraints { view in
            view.leading.trailing.equalToSuperview()
            view.bottom.equalToSuperview().offset(-2)
            view.top.equalTo(secondaryLabel.snp.bottom).offset(-2)
        }
    }
    
    func setText(primary: String, secondary: String) {
        self.primaryLabel.text = primary.uppercased()
        self.secondaryLabel.text = secondary.uppercased()
    }
}

