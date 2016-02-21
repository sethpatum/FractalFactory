//
//  MenuViewController.swift
//  first_game
//
//  Created by saman on 2/19/16.
//  Copyright © 2016 saman. All rights reserved.
//

import UIKit

var shaderfile : String = ""
var helpview : String = ""

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue", segue.identifier)
        shaderfile = segue.identifier! + ".fsh"
        helpview   = segue.identifier!
        
        // reset the position
        xoff.floatValue = 0
        yoff.floatValue = 0
        scale.floatValue = 1.0
        psca.floatValue = 1.0
        scrollStart = CGPoint(x:0.0, y:0.0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
