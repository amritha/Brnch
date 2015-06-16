//
//  EventViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    // salih 
    
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var foursquare : NSDictionary!
    var photos : NSDictionary!
    
    
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declare Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        
        //foursquare venue header image
        var venueId = "4aff8b4af964a520663922e3"
        var accessToken = "YTC10HGRAPCWLVP3VEHK122X23KEO30SHSUJ1GIPD4IIZQEE&v=20150614"
        
        var url = NSURL(string: "https://api.foursquare.com/v2/venues/\(venueId)/photos?oauth_token=\(accessToken)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            self.foursquare = json["response"] as! NSDictionary
            self.photos = self.foursquare.valueForKeyPath("photos") as! NSDictionary
            //println("\(self.photos)")
            var items = self.photos.valueForKeyPath("items") as! NSArray
            //println("\(items)")
            var prefix = items.valueForKeyPath("prefix") as! NSArray
            var suffix = items.valueForKeyPath("suffix") as! NSArray
            println("\(prefix[0])original\(suffix[0])")
            
            var photoUrl = NSURL(string: "\(prefix[3])original\(suffix[3])")
            
            self.venueImageView.setImageWithURL(photoUrl)
            
            
            }
        
        
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCounter(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        let month = components.month
        let year = components.year
        let day = components.day
        
        let currentDate = calendar.dateFromComponents(components)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //target date
        let userCalendar = NSCalendar.currentCalendar()
        
        
        let brunchDate = NSDateComponents()
        brunchDate.year = 2015
        brunchDate.month = 6
        brunchDate.day = 26
        brunchDate.hour = 11
        brunchDate.minute = 30
        brunchDate.second = 00
        let brunchDay = userCalendar.dateFromComponents(brunchDate)!
        
        //Compare dates
        // Here we compare the two dates
        brunchDay.timeIntervalSinceDate(currentDate!)
        
        let dayCalendarUnit: NSCalendarUnit = (.CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond )
        
        //here we change the seconds to hours,minutes and days
        let brunchDayDifference = userCalendar.components(
            dayCalendarUnit, fromDate: currentDate!, toDate: brunchDay,
            options: nil)
        //finally, here we set the variable to our remaining time
        var daysLeft = brunchDayDifference.day
        var hoursLeft = brunchDayDifference.hour
        var minutesLeft = brunchDayDifference.minute
        var secondsLeft = brunchDayDifference.second
        
        //daysLabel.text = String(daysLeft)
        if hoursLeft > 9
        {
        hoursLabel.text = String (hoursLeft)
        }
        else if hoursLeft < 10
        {
        hoursLabel.text = "0" + String(hoursLeft)
        }
        
        if minutesLeft > 9
        {
        minutesLabel.text = String(minutesLeft)
        }
        else if minutesLeft < 10
        {
        minutesLabel.text = "0" + String(minutesLeft)
        }
        
        if secondsLeft > 9 {
        secondsLabel.text = String(secondsLeft)
        }
        else if secondsLeft < 10
        {
        secondsLabel.text = "0" + String(secondsLeft)
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
