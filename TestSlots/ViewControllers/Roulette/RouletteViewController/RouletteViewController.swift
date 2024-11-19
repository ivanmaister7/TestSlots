//
//  RouletteViewController.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit
import SpriteKit

class RouletteViewController: UIViewController {

    @IBOutlet weak var rouletteGameView: UIView!
    @IBOutlet weak var footerView: UIFooterBetAndSpinView!
    
    private var skView: SKView!
    
    private(set) var rouletteScene: RouletteScene?
    private(set) var rouletteGameEngine = RouletteGameEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.addSettingsButton()
        
        footerView.spinDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        footerView.gameType = .roulette
    }
    
    override func viewDidLayoutSubviews() {
        self.addRouletteScene()
    }
    
    private func addRouletteScene() {
        guard skView == nil else { return }
        
        skView = SKView(frame: rouletteGameView.frame)
        skView.backgroundColor = .clear
        view.addSubview(skView)
        
        let scene = RouletteScene(size: rouletteGameView.frame.size)
        scene.rouletteDelegate = self
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        self.rouletteScene = scene
    }
}
