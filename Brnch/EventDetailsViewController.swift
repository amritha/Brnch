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
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    
    var invited: [String]!
    
    var location: NSDictionary!
    var address: String!
    var category: NSArray!
    var icons: NSArray!
    var prefix: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull Venue Name
        
        venueLabel.text = brnch.objectForKey("venue") as? String
        addressLabel.text = brnch.objectForKey("address") as? String
        
        var brunchDay = brnch.objectForKey("meet_day") as! String
        var brunchTime = brnch.objectForKey("meet_time") as! Int
        
        timeLabel.text = " \(brunchDay) @ \(brunchTime)ish"
        
        var profileCount = 1
        for item in invited {
            println(item)
            var label = UILabel(frame: CGRectMake(0, 0, 50, 50))
            label.center = CGPointMake(CGFloat(50 * profileCount), 100)
            label.textAlignment = NSTextAlignment.Center
            label.text = String(item[item.startIndex])
            self.view.addSubview(label)
            profileCount++

        }
        
        
        
        
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
