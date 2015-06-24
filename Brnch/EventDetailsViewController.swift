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
    
    
    @IBOutlet weak var tempProfileView: UIView!
    @IBOutlet weak var tempProfileLabel: UILabel!
    @IBOutlet weak var tempProfileCircle: UIImageView!
    
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
        
        var brunchDay = brnch.objectForKey("meet_day") as? String
        var brunchTime = brnch.objectForKey("meet_time") as! Int
        
        if brunchDay != nil {
            timeLabel.text = " \(brunchDay) @ \(brunchTime)ish"
        } else {
            timeLabel.text = "@ \(brunchTime)ish"
        }
        
        var profileCount : CGFloat = 0
        var profileOffset : CGFloat = 1
        var numberOfInvited = invited.count
        
        
        for item in invited {
            
            if profileCount < 5 {
                println(item)
                println(profileCount)
                var newView = UIView(frame: CGRectMake(tempProfileView.frame.origin.x, tempProfileView.frame.origin.y, tempProfileView.frame.width, tempProfileView.frame.height))
                newView.center = CGPoint(x: tempProfileView.center.x + (tempProfileView.frame.width * profileCount), y: tempProfileView.center.y)
                newView.backgroundColor = tempProfileView.backgroundColor
                self.view.addSubview(newView)
                
                var tempLabel = UILabel(frame: CGRectMake(tempProfileLabel.frame.origin.x, tempProfileLabel.frame.origin.y, tempProfileLabel.frame.width, tempProfileLabel.frame.height))
                tempLabel.center = tempProfileLabel.center
                tempLabel.textAlignment = NSTextAlignment.Center
                tempLabel.text = String(item[item.startIndex])
                tempLabel.font = tempProfileLabel.font
                tempLabel.textColor = tempProfileLabel.textColor
                newView.addSubview(tempLabel)
                
                var tempCircle = UIImageView(frame: CGRectMake(tempProfileCircle.frame.origin.x, tempProfileCircle.frame.origin.y, tempProfileCircle.frame.width, tempProfileCircle.frame.height))
                tempCircle.image = UIImage(named: "contact_img_yellow_mask")
                tempCircle.center = tempProfileCircle.center
                newView.addSubview(tempCircle)
                
                profileCount++
                
            } else if profileCount >= 5 {
                
                println(item)
                println(profileCount)
                var newView = UIView(frame: CGRectMake(tempProfileView.frame.origin.x, tempProfileView.frame.origin.y, tempProfileView.frame.width, tempProfileView.frame.height))
                newView.center = CGPoint(x: tempProfileView.center.x + (tempProfileView.frame.width * profileCount), y: tempProfileView.center.y)
                newView.backgroundColor = tempProfileView.backgroundColor
                self.view.addSubview(newView)
                
                var tempLabel = UILabel(frame: CGRectMake((tempProfileLabel.frame.origin.x * profileCount), tempProfileLabel.frame.origin.y, tempProfileLabel.frame.width, tempProfileLabel.frame.height))
                tempLabel.center = tempProfileLabel.center
                tempLabel.textAlignment = NSTextAlignment.Center
                var leftOverInvited = CGFloat(invited.count) - profileCount
                tempLabel.text = "+\(Int(leftOverInvited))"
                tempLabel.font = tempProfileLabel.font
                tempLabel.textColor = tempProfileLabel.textColor
                newView.addSubview(tempLabel)
                
                var tempCircle = UIImageView(frame: CGRectMake(tempProfileCircle.frame.origin.x, tempProfileCircle.frame.origin.y, tempProfileCircle.frame.width, tempProfileCircle.frame.height))
                tempCircle.image = UIImage(named: "contact_img_yellow_mask")
                tempCircle.center = tempProfileCircle.center
                newView.addSubview(tempCircle)
                
            }
            
        }
        
        
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
