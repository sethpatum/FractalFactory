//
//  GameScene.swift
//  first_game
//
//  Created by saman on 2/17/16.
//  Copyright (c) 2016 saman. All rights reserved.
//

import SpriteKit

let uni = SKUniform(name:"iter", float:10)

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        //let box = SKSpriteNode(imageNamed: "Bag_Black_Box_Sprite")
       // let box = SKSpriteNode(imageNamed: "Spaceship")
        let box = SKSpriteNode(color: UIColor(red:0.0, green:0.0, blue:0.0, alpha:1), size:CGSize(width: CGRectGetWidth(self.frame), height:CGRectGetHeight(self.frame)))
        let location = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        box.position = location
        
        let pattern = SKShader(fileNamed: "Frag.fsh")
        pattern.addUniform(uni)
        box.shader = pattern
        
        self.addChild(box)
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            uni.floatValue = Float(location.x/10.0)

        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
