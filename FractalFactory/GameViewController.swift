//
//  GameViewController.swift
//  first_game
//
//  Created by saman on 2/17/16.
//  Copyright (c) 2016 saman. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var SliderY: UISlider!
    @IBOutlet weak var SliderX: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Configure the view.
        let skView = self.view as! SKView
        let scene = GameScene(size: skView.bounds.size)
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
        print("SF", shaderfile)
        
        if shaderfile == "Simple.fsh" {
            SliderX.hidden = false
            SliderY.hidden = false
            
        } else {
            SliderX.hidden = true
            SliderY.hidden = true
        }
        
    }
    
    
    @IBAction func Xslider(sender: UISlider) {
        xslider.floatValue = Float(sender.value)
    }
    
    @IBAction func Yslider(sender: UISlider) {
        yslider.floatValue = Float(sender.value)
    }
    
    
    // doing the zooming by pinching
    // as being pinched, use the diff from previous to do incremental zooming
    @IBAction func doingPinch(sender: UIPinchGestureRecognizer) {
        let oldscale = scale.floatValue
        
        printpos()
        
        // (somewhat) centering the image while it is scaled
        xoff.floatValue +=  (xoff.floatValue-0.50)*(Float(sender.scale)/oldscale - 1.0)
        yoff.floatValue +=  (yoff.floatValue+0.50)*(Float(sender.scale)/oldscale - 1.0)
        
        scale.floatValue = Float(sender.scale)
        print("In Pinch", sender.scale)
        printpos()
    }
    
    
    // If finger is pressed for a long time, reset
    @IBAction func doingReset(sender: UILongPressGestureRecognizer) {
        print("Reset")
        xoff.floatValue = 0
        yoff.floatValue = 0
        scale.floatValue = 1.0
        psca.floatValue = 1.0
        scrollStart = CGPoint(x:0.0, y:0.0)
    }
    
    @IBAction func gotoHelp(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(helpview) as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
