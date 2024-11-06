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
    @IBOutlet weak var footerView: FooterBetAndSpinView!
    
    private var slotMachineScene: SlotMachineScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackButton()
        self.addSettingsButton()
        
        // Create a SpriteKit view and present the scene
        let skView = SKView(frame: slotsGameView.frame)
        skView.backgroundColor = .clear
        view.addSubview(skView)
        
        let scene = SlotMachineScene(size: slotsGameView.frame.size)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        self.slotMachineScene = scene
        
        footerView.playButton.addTarget(self, action: #selector(handleSpinButtonTapped), for: .touchUpInside)
    }
    
    @objc private func handleSpinButtonTapped() {
        slotMachineScene?.spinSlots()
    }
}

class SlotMachineScene: SKScene {
    
    private var slotImages: [SKSpriteNode] = []
    private var spinTimer: Timer?
    
    private let slotSymbols = [
        "Item1", "Item3", "Item3",
        "Item4", "Item5", "Item6", "Item7"
    ]
    private let rows = 3
    private let columns = 5
    private var slotWidth: Double { size.width / CGFloat(columns) }
    private var slotHeight: Double { size.height / CGFloat(rows) }

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setupUI()
    }

    private func setupUI() {
        for row in 0..<rows {
            for col in 0..<columns {
                let imageName = slotSymbols.randomElement() ?? slotSymbols[slotSymbols.count]
                let slot = SKSpriteNode(imageNamed: imageName)
                slot.size = CGSize(width: slotWidth, height: slotHeight)
                
                let xPosition = slotWidth * Double(col) + slotWidth / 2
                let yPosition = size.height - slotHeight * Double(row) - slotHeight / 2
                slot.position = CGPoint(x: xPosition, y: yPosition)
                
                slotImages.append(slot)
                addChild(slot)
            }
        }
    }
    
    func spinSlots() {
        slotImages[5...slotImages.count - 1].forEach { slot in
            slot.isHidden = true
        }
        
        let animationYStep = size.height - slotHeight / 2
        slotImages[0...4].forEach { slot in
            let spinAction = SKAction.sequence([
                SKAction.moveBy(x: 0, y: -animationYStep, duration: 0.05),
                SKAction.moveBy(x: 0, y: animationYStep, duration: 0.05)
            ])
            slot.run(SKAction.repeat(spinAction, count: 15))
        }

        spinTimer?.invalidate()
        spinTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                         target: self,
                                         selector: #selector(updateSlotSymbols),
                                         userInfo: nil,
                                         repeats: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self else { return }
            self.spinTimer?.invalidate()
            self.slotImages[5...self.slotImages.count - 1].forEach { slot in
                slot.isHidden = false
            }
        }
    }

    @objc private func updateSlotSymbols() {
        slotImages.forEach { slot in
            if let newImageName = slotSymbols.randomElement() {
                slot.texture = SKTexture(imageNamed: newImageName)
            }
        }
    }
}
