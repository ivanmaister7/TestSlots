//
//  SlotsViewController.swift
//  TestSlots
//
//  Created by ivan on 06.11.2024.
//

import UIKit
import SpriteKit

class SlotsViewController: UIViewController {
    
    @IBOutlet weak var slotsGameView: UIView!
    @IBOutlet weak var footerView: UIFooterBetAndSpinView!
    
    private var skView: SKView!
    
    private static let configuration: SlotMachineSceneConfiguration = .init()
    
    private(set) var slotMachineScene: SlotMachineScene?
    private(set) var slotsGameEngine = SlotsGameEngine(rows: configuration.rows,
                                                       columns: configuration.columns)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.addSettingsButton()
        
        footerView.spinDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        footerView.gameType = .slots
    }
    
    override func viewDidLayoutSubviews() {
        self.addSlotsScene()
    }
    
    private func addSlotsScene() {
        guard skView == nil else { return }
        
        skView = SKView(frame: slotsGameView.frame)
        skView.backgroundColor = .clear
        view.addSubview(skView)
        
        let scene = SlotMachineScene(size: slotsGameView.frame.size)
        scene.slotsDelegate = self
        scene.configuration = Self.configuration
        scene.scaleMode = .fill
        skView.presentScene(scene)
        
        self.slotMachineScene = scene
        
    }
}
