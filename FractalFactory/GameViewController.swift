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
    
    @IBOutlet weak var TextX: UITextField!
    @IBOutlet weak var TextY: UITextField!
    @IBOutlet weak var TextExp: UITextField!
    
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
        
        
        if shaderfile == "juliaset.fsh" || shaderfile == "sierpinski.fsh"  || shaderfile == "Simple.fsh" {
            SliderX.hidden = false
            SliderY.hidden = false
            LabelX.hidden = false
            LabelY.hidden = false
            TextY.hidden = false
            TextX.hidden = false
  
            if shaderfile == "sierpinski.fsh" || shaderfile == "Simple.fsh" {
                SliderExp.hidden = false
                LabelExp.hidden = false
                TextExp.hidden = false
            } else {
                SliderExp.hidden = true
                LabelExp.hidden = true
                TextExp.hidden = true
            }
        } else {
            SliderX.hidden = true
            SliderY.hidden = true
            SliderExp.hidden = true
            LabelX.hidden = true
            LabelY.hidden = true
            TextY.hidden = true
            LabelExp.hidden = true
            TextExp.hidden = true
            TextX.hidden = true
        }
        
        TextY.text = String(SliderY.value)
        TextExp.text = String(SliderExp.value)
        xslider.floatValue = SliderX.value
        yslider.floatValue = SliderY.value
        expslider.floatValue = SliderExp.value
        TextX.text = String(SliderX.value)
        
    }
    
    
    @IBAction func Xslider(sender: UISlider) {
        xslider.floatValue = Float(sender.value)
        TextX.text = String(sender.value)
    }
    
    @IBAction func Yslider(sender: UISlider) {
        yslider.floatValue = Float(sender.value)
        TextY.text = String(sender.value)
    }
    
    @IBAction func Expslider(sender: UISlider) {
        expslider.floatValue = Float(sender.value)
        TextExp.text = String(sender.value)
    }
    
    
    
    @IBAction func Xtextbox(sender: UITextField) {
        xslider.floatValue = Float(sender.text!)!
        SliderX.value = xslider.floatValue
    }
    
    @IBAction func Ytextbox(sender: UITextField) {
        yslider.floatValue = Float(sender.text!)!
        SliderY.value = yslider.floatValue

    }
    
    @IBAction func Exptextbox(sender: UITextField) {
        expslider.floatValue = Float(sender.text!)!
        SliderExp.value = expslider.floatValue

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
        TextX.text = String(0.32)
        
        yslider.floatValue = 0.44
        SliderY.value = 0.44
        TextY.text = String(0.44)
        
        expslider.floatValue = 0.0
        SliderExp.value = 0.0
        TextExp.text = String(0.0)
    }
    
    @IBAction func gotoHelp(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(helpview) as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    // Check for negative or positive decimal value
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string.characters.count == 0) {
            return true
        }
        
        var acceptable : String = ".0123456789"
        if(textField.text!.isEmpty) {
            acceptable = "-.0123456789"
        } else if (textField.text! as NSString).containsString(".") {
            acceptable = "0123456789"
        }
       
        let cs = NSCharacterSet(charactersInString: acceptable)
        let filtered = string.componentsSeparatedByCharactersInSet(cs).filter {  !$0.isEmpty }
        let str = filtered.joinWithSeparator("")
            
        return (string != str)

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
