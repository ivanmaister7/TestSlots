//
//  SettingsViewController.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    let privacyPolicyLink: String = "https://www.google.com"
    let touLink: String = "https://www.youtube.com"
    
#warning("replace true on Storage.IsSoundOn")
    var isSoundOn = true {
        didSet {
            let soundButton = buttonsStack.arrangedSubviews.first as? UICustomGreenButton
            soundButton?.setBackgroundImage(UIImage(resource: (isSoundOn ? .smallCornerButtonBg : .smallCornerButtonUnactiveBg)), for: .normal)
            soundButton?.setTitle("sound \(isSoundOn ? "on" : "off")".uppercased(), for: .normal)
        }
    }
    
    let buttonTitles: [(title: String, action: Selector)] = [
        ("sound on", #selector(soundOnTapped)),
        ("privacy policy", #selector(privacyPolicyTapped)),
        ("terms of use", #selector(touTapped)),
        ("share app", #selector(shareTapped))
    ]

    @IBOutlet weak var buttonsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackButton()
        self.addSettingsCloseButton()
        
        buttonTitles.forEach {
            let button = UICustomGreenButton(text: $0.title, image: .smallCornerButtonBg)
            button.addTarget(self, action: $0.action, for: .touchUpInside)
            self.buttonsStack.addArrangedSubview(button)
        }
    }
    
    @objc private func soundOnTapped() {
        isSoundOn.toggle()
    }
    
    @objc private func privacyPolicyTapped() {
        privacyPolicyLink.openURL()
    }
    
    @objc private func touTapped() {
        touLink.openURL()
    }
    
    @objc private func shareTapped() {
        self.shareApp()
    }
}
