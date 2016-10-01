//
//  BallController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BallController: Controller {
    
    var totalPoint = 0
    
    
    
    var check = false
    
    
    override func setup(_ parent: SKNode) {
        configPhysics()
        setupContact()
    }
    
    
    func setupContact()  {
        var count = 0
        self.view.handleContact = {
            otherView in
            if let brick = otherView as? BrickView {
                brick.removeFromParent()
                count += 1
                self.totalPoint += count
                print("total Point: \(self.totalPoint)")
                
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
        view.physicsBody?.contactTestBitMask = (bottomCategory | brickCategory)
    }
}
