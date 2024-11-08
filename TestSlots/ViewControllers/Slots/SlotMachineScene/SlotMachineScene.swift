//
//  SlotMachineScene.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import SpriteKit

class SlotMachineScene: SKScene {
    
    private var slotLabels: [SKSpriteNode] = []
    private var spinTimer: Timer?
    weak var slotsDelegate: SlotMachineSceneDelegate?
    var configuration: SlotMachineSceneConfiguration = .init()
    
    private let slotSymbols = SlotsModel.defaultImageMap
    
    private var slotWidth: Double {
        (size.width - configuration.columnSpacing * Double((configuration.columns - 1))) / CGFloat(configuration.columns)
    }
    private var slotHeight: Double {
        (size.height - configuration.rowSpacing * Double((configuration.rows - 1))) / CGFloat(configuration.rows)
    }
    
    override func didMove(to view: SKView) {
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        setupSlots()
    }
    
    private func setupSlots() {
        for row in 0..<configuration.rows {
            for col in 0..<configuration.columns {
                let slot = SKSpriteNode()
                slot.size = CGSize(width: slotWidth, height: slotHeight)
                
                let xPosition = slotWidth * Double(col) + configuration.columnSpacing * Double(col) + slotWidth / 2
                let yPosition = size.height - configuration.rowSpacing * Double(row) - slotHeight * Double(row) - slotHeight / 2
                slot.position = CGPoint(x: xPosition, y: yPosition)
                
                slotLabels.append(slot)
                addChild(slot)
            }
        }
        setupSlotsImages()
    }
    
    private func setupSlotsImages() {
        let positions = slotsDelegate?.getCurrentKeysPositions()
        for row in 0..<configuration.rows {
            for col in 0..<configuration.columns {
                let imageName = slotSymbols[positions?[row][col] ?? 0] ?? "Item1"
                let convertedIndex = (row * configuration.columns) + col
                slotLabels[convertedIndex].texture = SKTexture(imageNamed: imageName)
            }
        }
    }
    
    func spinSlots() {
        applyAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.46) { [weak self] in
            guard let self else { return }
            self.stopAnimation()
        }
    }
    
    private func applyAnimation() {
        hideSomeRows()
        
        moveVisibleRows()
        
        spinTimer?.invalidate()
        spinTimer = Timer.scheduledTimer(timeInterval: 0.05,
                                         target: self,
                                         selector: #selector(updateSlotSymbols),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func stopAnimation() {
        spinTimer?.invalidate()
        setupSlotsImages()
        slotLabels[5...slotLabels.count - 1].forEach { slot in
            slot.isHidden = false
        }
        slotsDelegate?.onFinishAnimation()
    }
    
    
    private func hideSomeRows() {
        slotLabels[5...slotLabels.count - 1].forEach { slot in
            slot.isHidden = true
        }
    }
    
    private func moveVisibleRows() {
        let animationYStep = size.height - slotHeight / 2
        slotLabels[0...4].forEach { slot in
            let spinAction = SKAction.sequence([
                SKAction.moveBy(x: 0, y: -animationYStep, duration: 0.05),
                SKAction.moveBy(x: 0, y: animationYStep, duration: 0.05)
            ])
            slot.run(SKAction.repeat(spinAction, count: 15))
        }
    }
    
    @objc private func updateSlotSymbols() {
        slotLabels.forEach { slot in
            if let newImageName = slotSymbols.values.randomElement() {
                slot.texture = SKTexture(imageNamed: newImageName)
            }
        }
    }
}
