//
//  PlinkoViewController.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import UIKit
import SpriteKit

class PlinkoViewController: UIViewController {

    @IBOutlet weak var plinkoGameView: UIView!
    @IBOutlet weak var footerView: UIFooterBetAndSpinView!
    
    private(set) var plinkoScene: PlinkoScene?
    private(set) var plinkoGameEngine = PlinkoGameEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSettingsButton()
        self.addBackButton()
        
        self.addPlinkoScene()
        
        footerView.spinDelegate = self
    }
    
    private func addPlinkoScene() {
        let skView = SKView(frame: plinkoGameView.frame)
        skView.backgroundColor = .clear
        view.addSubview(skView)
        
        let scene = PlinkoScene(size: plinkoGameView.frame.size)
        scene.plinkoDelegate = self
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        self.plinkoScene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        footerView.type = .version2
    }
}
