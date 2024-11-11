//
//  LoadingViewController.swift
//  TestSlots
//
//  Created by ivan on 05.11.2024.
//

import UIKit

class LoadingViewController: UIViewController {
    
    //MARK: Constants
    let loadingLabelText = "LOADING"
    let loadingLabelFont = UIFont.getJudson700(size: 18)
    let loadingLabelColor = UIColor.white
    let loadingAnimationDuration = 3.0
    
    var dotCount = 0 {
        didSet {
            if dotCount == 3 {
                dotCount = 0
            }
            self.loadingLabel.text = loadingLabelText + Array(repeating: ".", count: dotCount).joined()
        }
    }
    
    private var loadingTimer: Timer?
    
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        startLoadingAnimations()
    }
    
    private func setUpUI() {
        loadingLabel.text = loadingLabelText
        loadingLabel.font = loadingLabelFont
        loadingLabel.textColor = loadingLabelColor
    }
    
    private func startLoadingAnimations() {
        self.loadingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] _ in
            self?.dotCount += 1
        })
        
        //Use asyncAfter custom time only for demo.
        //We can invalidate() timer, for example, after loading some data
        DispatchQueue.main.asyncAfter(deadline: .now() + loadingAnimationDuration) {
            self.loadingTimer?.invalidate()
            SoundManager.shared
            StorageManager.defaults
            self.presentMenuViewController()
        }
    }
    
    private func presentMenuViewController() {
        let navVc = UINavigationController(rootViewController: MainMenuViewController())
        
        navVc.navigationBar.isHidden = true
        
        let keyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        keyWindow?.rootViewController = navVc
        
    }
}
