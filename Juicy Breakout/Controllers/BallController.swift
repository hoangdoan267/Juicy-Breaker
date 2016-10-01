//
//  BallController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BallController: Controller {
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact()
    }
    
    func setupContact()  {
        self.view.handleContact = {
            otherView in
            if let brick = otherView as? BrickView {
                brick.removeFromParent()
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
        view.physicsBody?.contactTestBitMask = (bottomCategory | brickCategory)
    }
}
