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
    
    @IBOutlet weak var SliderX: UISlider!
    @IBOutlet weak var SliderY: UISlider!
    @IBOutlet weak var SliderExp: UISlider!
    @IBOutlet weak var LabelX: UILabel!
    @IBOutlet weak var LabelY: UILabel!
    @IBOutlet weak var LabelExp: UILabel!
    @IBOutlet weak var LabelXval: UILabel!
    @IBOutlet weak var LabelYval: UILabel!
    @IBOutlet weak var LabelExpval: UILabel!
    
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
        
        if shaderfile == "juliaset.fsh" || shaderfile == "sierpinski.fsh" {
            SliderX.hidden = false
            SliderY.hidden = false
            LabelX.hidden = false
            LabelY.hidden = false
            LabelXval.hidden = false
            LabelYval.hidden = false
  
            if shaderfile == "sierpinski.fsh" {
                SliderExp.hidden = false
                LabelExp.hidden = false
                LabelExpval.hidden = false
            } else {
                SliderExp.hidden = true
                LabelExp.hidden = true
                LabelExpval.hidden = true
            }
        } else {
            SliderX.hidden = true
            SliderY.hidden = true
            SliderExp.hidden = true
            LabelX.hidden = true
            LabelY.hidden = true
            LabelXval.hidden = true
            LabelYval.hidden = true
            LabelExp.hidden = true
            LabelExpval.hidden = true
            print("Here 3")
        }
        
        LabelXval.text = String(SliderX.value)
        LabelYval.text = String(SliderY.value)
        LabelExpval.text = String(SliderExp.value)
        xslider.floatValue = SliderX.value
        yslider.floatValue = SliderY.value
        expslider.floatValue = SliderExp.value
        
    }
    
    
    @IBAction func Xslider(sender: UISlider) {
        xslider.floatValue = Float(sender.value)
        LabelXval.text = String(sender.value)
    }
    
    @IBAction func Yslider(sender: UISlider) {
        yslider.floatValue = Float(sender.value)
        LabelYval.text = String(sender.value)
    }
    
    @IBAction func Expslider(sender: UISlider) {
        expslider.floatValue = Float(sender.value)
        LabelExpval.text = String(sender.value)
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
        
        
        xslider.floatValue = 0.32
        SliderX.value = 0.32
        LabelXval.text = String(0.32)
        
        yslider.floatValue = 0.44
        SliderY.value = 0.44
        LabelYval.text = String(0.44)
        
        expslider.floatValue = 0.0
        SliderExp.value = 0.0
        LabelExpval.text = String(0.0)
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
