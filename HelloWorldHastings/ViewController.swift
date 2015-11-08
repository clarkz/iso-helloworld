//
//  ViewController.swift
//  HelloWorldHastings
//
//  Created by Yuejiang Zhang on 2015-10-15.
//  Copyright © 2015 Yuejiang Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbMsg: UILabel!
    
    @IBOutlet weak var selectDate: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selDate(sender: UIDatePicker) {
        displayGCInfo()
    }

    func applicationDidBecomeActive(notification: NSNotification) {
        displayGCInfo()
    }
    
    func displayGCInfo(){
        let calculator: NextGarbageCollectionCalculation = NextGarbageCollectionCalculation()
        
        let nextGCDateInfo = calculator.getNextCollectionDate(selectDate.date)
        
        lbMsg.text = nextGCDateInfo.nextCollectionDateDesc + ", " + nextGCDateInfo.binColor
        
        if(nextGCDateInfo.binColor == "Blue"){
            lbMsg.textColor = UIColor.blueColor()
        }else{
            lbMsg.textColor = UIColor.blackColor()
        }
    }
}

