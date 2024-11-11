//
//  YouWinAlertViewController.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit

class YouWinAlertViewController: UIViewController {

    @IBOutlet weak var alertBackground: UIImageView!
    @IBOutlet weak var congratulationLabel: UILabel!
    @IBOutlet weak var youWinLabel: UILabel!
    @IBOutlet weak var youWinStack: UIStackView!
    
    var bg: ImageResource
    
    lazy var playMoreButton: UICustomGreenButton = {
        let button = UICustomGreenButton(text: "play more", image: .smallCornerButtonBg)
        button.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(bg: ImageResource){
        self.bg = bg
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        alertBackground.image = UIImage(resource: bg)
        
        youWinLabel.text = "You Win!"
        youWinLabel.textColor = .white
        youWinLabel.font = .getInter700(size: 26)
        
        congratulationLabel.text = "Congratulations!"
        congratulationLabel.textColor = .white
        congratulationLabel.font = .getInter700(size: 22)
        
        youWinStack.addArrangedSubview(playMoreButton)
    }
}
