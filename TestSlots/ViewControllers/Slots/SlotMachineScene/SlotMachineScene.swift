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
        for row in 0...configuration.rows {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self else { return }
            self.stopAnimation()
        }
    }
    
    private func applyAnimation() {
        moveVisibleRows()
        
        spinTimer?.invalidate()
        spinTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(updateSlotSymbols),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func stopAnimation() {
        spinTimer?.invalidate()
        setupSlotsImages()
    }
    
    private func moveVisibleRows() {
        let animationYStep = slotHeight
        let moveDown = SKAction.moveBy(x: 0, y: -animationYStep, duration: 0.1)
        let resetPosition = SKAction.moveBy(x: 0, y: animationYStep, duration: 0.0)
        
        let spinAction = SKAction.sequence([moveDown, resetPosition])
        let spinActionCyclic = SKAction.repeat(spinAction, count: 20)
        
        let fullAction = SKAction.sequence([
            resetPosition,
            spinActionCyclic,
            moveDown
        ])
        fullAction.timingMode = .easeOut
        
        slotLabels.forEach { $0.run(fullAction) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fullAction.duration) { [weak self] in
            guard let self else { return }
            self.slotsDelegate?.onFinishAnimation()
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
