//
//  GameScene.swift
//  first_game
//
//  Created by saman on 2/17/16.
//  Copyright (c) 2016 saman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        //let box = SKSpriteNode(imageNamed: "Bag_Black_Box_Sprite")
        let box = SKSpriteNode(imageNamed: "Spaceship")
        let location = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        box.position = location
        
        let pattern = SKShader(fileNamed: "Frag.fsh")
        box.shader = pattern
        
        self.addChild(box)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
