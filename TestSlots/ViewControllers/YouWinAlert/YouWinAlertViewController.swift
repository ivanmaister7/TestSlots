//
//  YouWinAlertViewController.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit

enum YouWinAlertType {
    case win, lose
}

class YouWinAlertViewController: UIViewController {

    @IBOutlet weak var alertBackground: UIImageView!
    @IBOutlet weak var congratulationLabel: UILabel!
    @IBOutlet weak var youWinLabel: UILabel!
    @IBOutlet weak var youWinStack: UIStackView!
    
    let youWinTitle = "You Win!"
    let congratulationsTitle = "Congratulations!"
    let playMoreTitle = "play more"
    
    let youLoseTitle = "Your balance is empty!"
    let youLoseInstractionsTitle = "Please, restart the game!"
    let restartGameTitle = "restart game"
    
    private var bg: ImageResource
    private var type: YouWinAlertType
    
    lazy var playMoreButton: UICustomGreenButton = {
        let button = UICustomGreenButton(text: type == .win ? playMoreTitle : restartGameTitle, image: .smallCornerButtonBg)
        let selector: Selector = type == .win ? #selector(self.backButtonTapped) : #selector(self.restartGame)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }()
    
    init(bg: ImageResource, type: YouWinAlertType = .win){
        self.bg = bg
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        
        alertBackground.image = UIImage(resource: bg)
        
        youWinLabel.text = type == .win ? youWinTitle : youLoseTitle
        youWinLabel.textColor = .white
        youWinLabel.font = .getOpenSans700(size: 26)
        
        congratulationLabel.text = type == .win ? congratulationsTitle : youLoseInstractionsTitle
        congratulationLabel.textColor = .white
        congratulationLabel.font = .getOpenSans700(size: 22)
        
        youWinStack.addArrangedSubview(playMoreButton)
    }
}
