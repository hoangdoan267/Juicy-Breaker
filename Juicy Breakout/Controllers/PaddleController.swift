//
//  PaddleController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class PaddleController: Controller {
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact(parent: parent)
    }
    
    func setupContact(parent: SKNode) {
        self.view.handleContact = {
            otherView in
            if let paddle = otherView as? GiftView {
                paddle.removeFromParent()
                //self.view.setScale(1.5)
                parent.run(SKAction.playSoundFileNamed("extend.wav", waitForCompletion: false))
                self.view.run(SKAction.scale(by: 1.5, duration: 0.5))
                
                
            }
        }
    }
    
    
    func configPhysics() {
        
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.friction = 0.4
        view.physicsBody?.isDynamic = false
        view.physicsBody?.restitution = 0.1
        view.physicsBody?.categoryBitMask = paddleCategory
        view.physicsBody?.contactTestBitMask = giftCategory
    }
}
