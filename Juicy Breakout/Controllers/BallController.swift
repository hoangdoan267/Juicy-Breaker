//
//  BallController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BallController: Controller {
    
    var time = 0
    var count = 0
    
    var check = false
    
    
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact(parent: parent)
        setupContact(parent : parent)

    }
    
    

    func setupContact(parent: SKNode)  {
        
        self.view.handleContact = {
            otherView in
            if let paddle = otherView as? PaddleView {
                self.count = 0
                self.time = 0
                parent.run(SKAction.playSoundFileNamed("paddleBlip.wav", waitForCompletion: false))
            }
            
            if let brick = otherView as? BrickView {
               
                
                brick.removeFromParent()
                parent.run(SKAction.playSoundFileNamed("BambooBreak.wav", waitForCompletion: false))
                print(brick.level)
                if brick.level == 1 {
                    self.count += 1
                    self.time = 0
                    let particle = SKEmitterNode(fileNamed: "BrokenPlatform.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                }
                
                if brick.level == 2 {
                    self.time += 2
                    print(self.time)
                    self.count = 0
                    let particle = SKEmitterNode(fileNamed: "break_level_2.sks")
                    particle?.position = brick.position
                    parent.addChild(particle!)
                }
                
                //self.totalPoint += self.count
                GameScene.score += self.count + self.time
                
            }
            if let bottomBorder = otherView as? BottomView {
                self.view.removeFromParent()
                self.check = true
            }
            
            
        }
    }
    
    
    func configPhysics() {
        view.name = "ball"
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.friction = 0
        view.physicsBody?.allowsRotation = false
        view.physicsBody?.restitution = 1
        view.physicsBody?.linearDamping = 0
        view.physicsBody?.applyImpulse(CGVector(dx: 0.75 , dy: 0.75))
        view.physicsBody?.categoryBitMask = ballCategory
        view.physicsBody?.contactTestBitMask = (bottomCategory | brickCategory | paddleCategory)
    }
}
