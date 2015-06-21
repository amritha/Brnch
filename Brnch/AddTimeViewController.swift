//
//  AddTimeViewController.swift
//  Brnch
//
//  Created by MesoLaptop15 on 6/16/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class AddTimeViewController: UIViewController {

    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var elevenButton: UIButton!
    @IBOutlet weak var twelveButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    var brnch : PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPress(sender: AnyObject) {
        if sender as! NSObject == tenButton{
            tenButton.selected = true
            elevenButton.selected = false
            twelveButton.selected = false
            oneButton.selected = false
            
            //Save time to parse
            brnch["meet_time"] = 10
            brnch.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("saved time")
                } else {
                    println("error time")
                }
            }

        }
        else if sender as! NSObject == elevenButton{
            tenButton.selected = false
            elevenButton.selected = true
            twelveButton.selected = false
            oneButton.selected = false
            
            //Save time to parse
            brnch["meet_time"] = 11
            brnch.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("saved time")
                } else {
                    println("error time")
                }
            }

        }
        else if sender as! NSObject == twelveButton{
            tenButton.selected = false
            elevenButton.selected = false
            twelveButton.selected = true
            oneButton.selected = false
            
            //Save time to parse
            brnch["meet_time"] = 12
            brnch.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("saved time")
                } else {
                    println("error time")
                }
            }

        }
        else if sender as! NSObject == oneButton{
            tenButton.selected = false
            elevenButton.selected = false
            twelveButton.selected = false
            oneButton.selected = true
            
            //Save time to parse
            brnch["meet_time"] = 1
            brnch.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("saved time")
                } else {
                    println("error time")
                }
            }

        }
        else{
        println("Error")
        }
        
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
