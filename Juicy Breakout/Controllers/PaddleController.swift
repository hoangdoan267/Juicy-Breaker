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
    }
    
    func configPhysics() {
        view.physicsBody = SKPhysicsBody(rectangleOf: view.frame.size)
        view.physicsBody?.friction = 0.4
        view.physicsBody?.isDynamic = false
        view.physicsBody?.restitution = 0.1
        view.physicsBody?.categoryBitMask = paddleCategory
    }
}
