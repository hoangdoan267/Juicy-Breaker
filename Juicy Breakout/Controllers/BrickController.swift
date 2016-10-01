//
//  BrickController.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 10/1/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class BrickController: Controller {
    override func setup(_ parent: SKNode) {
        configPhysics()
    }
    
    func configPhysics() {
        view.name = "brick"
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.allowsRotation = false
        view.physicsBody?.friction = 0
        view.physicsBody?.categoryBitMask = brickCategory
        view.physicsBody?.collisionBitMask = 0
    }
}
