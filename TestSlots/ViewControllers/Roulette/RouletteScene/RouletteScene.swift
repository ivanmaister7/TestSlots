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
        let preRotateAction = SKAction.rotate(byAngle: preRotateAngle, duration: preRotateAngle / -.pi_2) // t=S/v
        
        let rotateAction = SKAction.rotate(byAngle: -.pi_2, duration: 1)
        let repeatAction = SKAction.repeat(rotateAction, count: 3)
        
        lastAngleRotation = -(rouletteDelegate?.getFinalAngle() ?? .pi_2)
        let finalRotateAction = SKAction.rotate(byAngle: lastAngleRotation, duration: lastAngleRotation / -.pi_2 * 3) // t=S/v*4 to make slow rotating at the end of animation
        let onFinishAction = SKAction.run(rouletteDelegate?.onFinishAnimation ?? {})
        
        circleNode.run(SKAction.sequence([preRotateAction, repeatAction, finalRotateAction, onFinishAction]), withKey: "spinAction")
        
    }
}
