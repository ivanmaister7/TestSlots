//
//  PlinkoScene.swift
//  TestSlots
//
//  Created by ivan on 11.11.2024.
//

import SpriteKit

class PlinkoScene: SKScene, SKPhysicsContactDelegate {
    
    let rows = 7
    let columns = 3
    
    let bucketImages = PlinkoModel.defaultImageMap
    
    weak var plinkoDelegate: PlinkoSceneDelegate?
    private var ballNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        createPlinkoBoard()
    }
    
    private func createPlinkoBoard() {
        let pegSize = CGSize(width: 15, height: 15)
        
        let spacingX: CGFloat = 35
        let spacingY: CGFloat = 40
        
        for row in 0..<rows {
            let pegsInRow = columns + row
            for col in 0..<pegsInRow {
                let peg = SKSpriteNode(imageNamed: "smallBall")
                peg.size = pegSize
                peg.position = CGPoint(
                    x: size.width / 2 + CGFloat(col - pegsInRow / 2) * spacingX + (row % 2 == 0 ? 0 : spacingX / 2),
                    y: size.height * 0.82 - CGFloat(row) * spacingY
                )
                
                peg.physicsBody = SKPhysicsBody(circleOfRadius: pegSize.width / 2)
                peg.physicsBody?.isDynamic = false
                peg.name = "peg"
                
                peg.physicsBody?.categoryBitMask = PlinkoCollisionBitMask.peg.rawValue
                peg.physicsBody?.contactTestBitMask = PlinkoCollisionBitMask.ball.rawValue
                
                addChild(peg)
            }
        }
        
        let bucketSpacing = 8.0
        let bucketWidth = size.width / CGFloat(rows) - 3 - bucketSpacing
        let bucketSize = CGSize(width: bucketWidth, height: bucketWidth / 1.75)
        
        for i in 0..<rows {
            let bucket = SKSpriteNode(imageNamed: bucketImages[i] ?? "bucket1")
            bucket.size = bucketSize
            bucket.position = CGPoint(x: bucketSpacing * CGFloat(i + 4) + bucketWidth * CGFloat(i),
                                      y: bucketSpacing * 2)
            bucket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bucketWidth, height: 20))
            bucket.physicsBody?.isDynamic = false
            bucket.name = "bucket\(i + 1)"
            
            bucket.physicsBody?.categoryBitMask = PlinkoCollisionBitMask.bucket.rawValue
            bucket.physicsBody?.contactTestBitMask = PlinkoCollisionBitMask.peg.rawValue
            
            addChild(bucket)
        }
    }
    
    func dropBall() {
        let ballRadius = 8.5
        let ballSize = CGSize(width: ballRadius * 2, height: ballRadius * 2)
        
        ballNode = SKSpriteNode(imageNamed: "bigBall")
        ballNode.size = ballSize
        ballNode.position = CGPoint(x: size.width / 2 + 10, y: size.height - 30)
        
        // Add physics body to the ball
        ballNode.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ballNode.physicsBody?.restitution = 0.5
        ballNode.physicsBody?.friction = 0.1
        ballNode.physicsBody?.linearDamping = 0.3
        ballNode.name = "ball"
        
        ballNode.physicsBody?.categoryBitMask = PlinkoCollisionBitMask.ball.rawValue
        ballNode.physicsBody?.contactTestBitMask = PlinkoCollisionBitMask.peg.rawValue | PlinkoCollisionBitMask.bucket.rawValue
        
        addChild(ballNode)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }

        if (nodeA.name == "ball" && nodeB.name == "peg") || (nodeA.name == "peg" && nodeB.name == "ball") {
            addRandomBounce(to: nodeA.name == "ball" ? nodeA : nodeB)
        } else if (nodeA.name == "ball" && nodeB.name?.starts(with: "bucket") == true) ||
                    (nodeB.name == "ball" && nodeA.name?.starts(with: "bucket") == true) {
            
            let bucketNode = nodeA.name?.starts(with: "bucket") == true ? nodeA : nodeB
            for (key, imageName) in bucketImages {
                if bucketNode.name == imageName {
                    ballNode.removeFromParent()
                    plinkoDelegate?.setFinalBucket(key)
                    plinkoDelegate?.onFinishAnimation()
                    break
                }
            }
        }
    }
    
    private func addRandomBounce(to node: SKNode) {
        let randomDirection = CGFloat.random(in: -1...1) // Choose a random direction
        let randomImpulse = CGVector(dx: randomDirection * 1.5, dy: 0) // Apply random impulse in X direction
        node.physicsBody?.applyImpulse(randomImpulse)
    }
}
