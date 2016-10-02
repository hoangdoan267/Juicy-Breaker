//
//  GameMenu.swift
//  Juicy Breakout
//
//  Created by SonVu on 10/2/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GameMenuScene: SKScene {
    override func didMove(to view: SKView) {
        //self.view?.backgroundColor = UIColor(patternImage: UIImage(named:"space.jpg")!)
        let bg = SKSpriteNode.init(imageNamed: "space.jpg")
        addChild(bg)
        //button
        let btPlay = SKSpriteNode(imageNamed: "playbutton.png")
        //
        btPlay.size = CGSize(width: 130, height: 50)
        //
        btPlay.name = "Play"
        //
        btPlay.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - btPlay.frame.height)
        
        addChild(btPlay)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchNodes = self.nodes(at: location)
            for node in touchNodes {
                if(node.name == "Play") {
                    //1 creat secent
                    let gameScene = GameScene(size: (self.view?.frame.size)!)
                    //2 transport
                    self.view?.presentScene(gameScene, transition: SKTransition.fade(with: UIColor.black, duration: 0.5))
                }
            }
        }
        
    }
}
