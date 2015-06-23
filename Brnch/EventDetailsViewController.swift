//
//  EventDetailsViewController.swift
//  Brnch
//
//  Created by MesoLaptop15 on 6/22/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

    var brnch : PFObject!
    
    @IBOutlet weak var venueLabel: UILabel!
    
    var invited: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull Venue Name
        var venue = brnch.objectForKey("venue") as? String
        venueLabel.text = venue
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func didPressEditBrunch(sender: AnyObject) {
        
        performSegueWithIdentifier("editEventSegue", sender: self)
        
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
