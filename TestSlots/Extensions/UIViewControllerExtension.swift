//
//  UIViewControllerExtension.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit

extension UIViewController {
    func shareApp() {
        
#warning("Replace appUrl and message to config file")
        let appURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID")!
        let message = "Check out this awesome app!"
        
        let itemsToShare: [Any] = [message, appURL]
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            .assignToContact,
            .addToReadingList,
            .saveToCameraRoll
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func addSettingsCloseButton(settingsImage: UIImage = UIImage(resource: .settingsIconBg),
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
        settingsButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    func addSettingsButton(settingsImage: UIImage = UIImage(resource: .settingsIconBg),
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
    
    func addBackButton(backImage: UIImage = UIImage(resource: .backIconBg),
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
        present(SettingsViewController(), animated: true)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
