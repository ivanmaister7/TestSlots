//
//  RouletteScene.swift
//  TestSlots
//
//  Created by ivan on 08.11.2024.
//

import SpriteKit

class RouletteScene: SKScene {
    
    private var circleNode: SKSpriteNode!
    weak var rouletteDelegate: RouletteSceneDelegate?
    
    var lastAngleRotation: Angle = 0.0
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        
        setupCircle()
        setupBackground()
        setupPin()
    }
    
    private func setupPin() {
        let pinNode = SKSpriteNode(imageNamed: "PinRoulette")
        pinNode.position = CGPoint(x: frame.midX, y: frame.midY)
        pinNode.size = CGSize(width: frame.width * 0.15, height: frame.width * 0.15)
        addChild(pinNode)
    }
    
    private func setupBackground() {
        let borderBackground = SKSpriteNode(imageNamed: "BorderRoulette")
        borderBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        borderBackground.size = CGSize(width: frame.width, height: frame.width)
        addChild(borderBackground)
    }
    
    private func setupCircle() {
        circleNode = SKSpriteNode(imageNamed: "CircleRoulettee")
        circleNode.position = CGPoint(x: frame.midX, y: frame.midY)
        circleNode.size = CGSize(width: frame.width * 0.95, height: frame.width * 0.95)
        addChild(circleNode)
    }
    
    func spinAction() {
        let preRotateAngle = -.pi_2 - lastAngleRotation
        
        lastAngleRotation = -(rouletteDelegate?.getFinalAngle() ?? .pi_2)
        
        let rotateAction = SKAction.rotate(byAngle: preRotateAngle + (-.pi_2 * 5) + lastAngleRotation, duration: 6.0)
        rotateAction.timingMode = .easeInEaseOut
        
        let onFinishAction = SKAction.run(rouletteDelegate?.onFinishAnimation ?? {})
        
        circleNode.run(SKAction.sequence([rotateAction, onFinishAction]), withKey: "spinAction")
    }
}
