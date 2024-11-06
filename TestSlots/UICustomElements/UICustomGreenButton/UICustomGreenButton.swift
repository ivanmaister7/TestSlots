//
//  UICustomGreenButton.swift
//  TestSlots
//
//  Created by ivan on 05.11.2024.
//

import Foundation
import UIKit

@objc enum ImageStyle: Int {
    case smallRound, largeRound
}

class UICustomGreenButton: UIButton {
    
    convenience init(text: String, image: ImageResource = .smallCornerButtonBg) {
        self.init()
        setupButton(image)
        self.setTitle(text.uppercased(), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton(_ image: ImageResource = .smallCornerButtonBg) {
        self.setBackgroundImage(UIImage(resource: image), for: .normal)
        self.titleLabel?.font = .getInter700(size: 28)
        self.titleLabel?.textAlignment = .center
        
        self.titleLabel?.layer.shadowColor = UIColor.black.withAlphaComponent(0.9).cgColor // #000000E5
        self.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.titleLabel?.layer.shadowOpacity = 1.0
        self.titleLabel?.layer.shadowRadius = 1.0
        
//        self.titleLabel?.layer.borderColor = UIColor.black.withAlphaComponent(0.16).cgColor
//        self.titleLabel?.layer.borderWidth = 0.5
        
        layer.masksToBounds = false
    }
}
