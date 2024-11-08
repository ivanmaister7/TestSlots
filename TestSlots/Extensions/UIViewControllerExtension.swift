//
//  UIViewControllerExtension.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

extension UIViewController {
    func addSettingsButton(settingsImage: UIImage = UIImage(resource: .settingsBg),
                           buttonSize: CGFloat = 50.0,
                           offset: CGFloat = 24.0) {
        
        let settingsButton = UIButton()
        settingsButton.setBackgroundImage(settingsImage, for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: buttonSize),
            settingsButton.heightAnchor.constraint(equalToConstant: buttonSize),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    func addBackButton(backImage: UIImage = UIImage(resource: .backBg),
                       buttonSize: CGFloat = 50.0,
                       offset: CGFloat = 24.0) {
        
        let backButton = UIButton()
        backButton.setBackgroundImage(backImage, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: buttonSize),
            backButton.heightAnchor.constraint(equalToConstant: buttonSize),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func settingsButtonTapped() {
        print("Settings button tapped")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
