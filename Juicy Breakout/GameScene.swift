//
//  GameScene.swift
//  Juicy Breakout
//
//  Created by Hoang Doan on 9/29/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var paddle:SKSpriteNode!
    var ball:SKSpriteNode!
    var bottom:SKSpriteNode!
    
    let ballCategory = UInt32(1<<0)
    let bottomCategory = UInt32(1<<1)
    let brickCategory = UInt32(1<<2)
    let paddleCategory = UInt32(1<<3)
    
    
    
    override func didMove(to view: SKView) {
        configBorder()
        addBackGround()
        addPaddle()
        addBall()
        addBottom()
        addBricks()
        configCollision()
        
    }
    
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addBackGround() {
        let backGround = SKSpriteNode(color: UIColor(red:0.97, green:0.95, blue:0.70, alpha:1.0), size: self.frame.size)
        backGround.anchorPoint = CGPoint.zero
        addChild(backGround)
    }
    
    func configBorder() {
        let worldBorder = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = worldBorder
        self.physicsBody?.friction = 0
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func addBall() {
        ball = SKSpriteNode(color: UIColor(red:0.83, green:0.40, blue:0.21, alpha:1.0), size: CGSize(width: 10, height: 10))
        ball.position = CGPoint(x: self.frame.width/2, y: self.frame.height/4)
        
        self.addChild(ball)
        ball.physicsBody = SKPhysicsBody(rectangleOf: ball.frame.size)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.applyImpulse(CGVector(dx: 0.75 , dy: -0.75))
        
    }
    
    func addPaddle()  {
        paddle = SKSpriteNode(color: UIColor(red:0.81, green:0.22, blue:0.27, alpha:1.0), size: CGSize(width: 100, height: 10))
        paddle.position = CGPoint(x: self.frame.width/2, y: paddle.frame.height * 5)
        paddle.name = "paddeCategoryName"
        self.addChild(paddle)
        
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.frame.size)
        paddle.physicsBody?.friction = 0.4
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.restitution = 0.1
        
    }
    
    func addBottom() {
        let bottomRect = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: 1))
        bottom = SKSpriteNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        self.addChild(bottom)
    }
    
    func addBricks() {
        let numberOfRows = 6
        let numberOfBricks = 6
        let brickWidth = 40
        let padding = 5
        let offset = Float(self.frame.size.width) - Float(brickWidth * numberOfBricks + padding * (numberOfBricks) - 1 )
    
        let finalOffset = offset / 2
        
        for index in 1 ... numberOfRows {
            
            
            var yOffset:CGFloat {
                switch index {
                case 1:
                    return self.frame.size.height * 0.9
                case 2:
                    return self.frame.size.height * 0.85
                case 3:
                    return self.frame.size.height * 0.8
                case 4:
                    return self.frame.size.height * 0.75
                case 5:
                    return self.frame.size.height * 0.7
                case 6:
                    return self.frame.size.height * 0.65
                default:
                    return 0
                }
            }
            
            
            for index in 1 ... numberOfBricks {
                let brick = SKSpriteNode(color: UIColor(red:0.38, green:0.74, blue:0.52, alpha:1.0), size: CGSize(width: 40, height: 15))
                brick.name = "brick"
                
                let calc1:Float = Float(index) - 0.5
                let calc2:Float = Float(index) - 1
                let position = CGFloat(calc1  * Float(brick.frame.size.width) + calc2 * Float(padding) + finalOffset)
                
                brick.position = CGPoint(x: position, y: yOffset)
                brick.physicsBody = SKPhysicsBody(rectangleOf: brick.frame.size)
                brick.physicsBody?.allowsRotation = false
                brick.physicsBody?.friction = 0
                brick.physicsBody?.categoryBitMask = brickCategory
                brick.physicsBody?.collisionBitMask = 0
                
                
                self.addChild(brick)
                
                
                
            }
        }
        
    }
    
    func configCollision() {
        self.physicsWorld.contactDelegate = self
        ball.physicsBody?.categoryBitMask = ballCategory
        paddle.physicsBody?.categoryBitMask = paddleCategory
        bottom.physicsBody?.categoryBitMask = bottomCategory
        ball.physicsBody?.contactTestBitMask = (bottomCategory | brickCategory)
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        let prevLocation = touch?.previousLocation(in: self)
        
        var newPos = self.paddle.position.x + ((touchLocation?.x)! - (prevLocation?.x)!)
        
        newPos = max(newPos, self.paddle.size.width/2)
        newPos = min(newPos, self.frame.width - self.paddle.frame.width/2)
        self.paddle.position = CGPoint(x: newPos, y: self.paddle.position.y)
        
    }
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if  contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
//        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == bottomCategory {
//
//        }
        
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == brickCategory {
            secondBody.node?.removeFromParent()
        }
        
        
    }
    
    
}
