//
//  ClosedViewController.swift
//  Brnch
//
//  Created by Josh Bisch on 6/21/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class ClosedViewController: UIViewController {
    
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var countdownNumber: UILabel!
    @IBOutlet weak var spinnerImage: UIImageView!
    
    var timer = NSTimer()
    var rotating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declare Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: Selector("updateCountdown"), userInfo: nil, repeats: true)
        
        rotating = true
        rotateOnce()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateCountdown (){
        //Get the current date & user's calendar
        let currentDate = NSDate()
        let userCalendar = NSCalendar.currentCalendar()
        
        // Get the date for the next user's brunch
        let nextBrunchComponents = NSDateComponents()
        nextBrunchComponents.year = 2015
        nextBrunchComponents.month = 6
        nextBrunchComponents.day = 23
        nextBrunchComponents.hour = 8
        nextBrunchComponents.minute = 0
        let nextBrunch = userCalendar.dateFromComponents(nextBrunchComponents)!
        
        
        // How many days, hours, minutes, and seconds between
        // now and saturdayBrunch?
        let dayHourMinuteSecond: NSCalendarUnit =
            .CalendarUnitDay    |
            .CalendarUnitHour   |
            .CalendarUnitMinute |
            .CalendarUnitSecond
        
        let difference = NSCalendar.currentCalendar().components(
            dayHourMinuteSecond,
            fromDate: currentDate,
            toDate: nextBrunch,
            options: nil)
        
        if difference.day == 0 && difference.hour == 0 && difference.minute < 1 {
            self.countdownNumber.text = "\(difference.second)"
            self.countdownLabel.text = "SECONDS TO GO"
        } else if difference.day == 0 && difference.hour == 0 && difference.minute == 1 {
            self.countdownNumber.text = "\(difference.minute)"
            self.countdownLabel.text = "MINUTE TO GO"
        } else if difference.day == 0 && difference.hour == 0 && difference.minute > 1 {
            self.countdownNumber.text = "\(difference.minute)"
            self.countdownLabel.text = "MINUTES TO GO"
        } else if difference.day == 0 && difference.hour == 1 {
            self.countdownNumber.text = "\(difference.hour)"
            self.countdownLabel.text = "HOUR TO GO"
        } else if difference.day == 0 && difference.hour > 1 {
            self.countdownNumber.text = "\(difference.hour)"
            self.countdownLabel.text = "HOURS TO GO"
        } else if difference.day == 1 {
            self.countdownNumber.text = "\(difference.day)"
            self.countdownLabel.text = "DAY TO GO"
        } else if difference.day > 1 {
            self.countdownLabel.text = "\(difference.day)"
            self.countdownLabel.text = "DAYS TO GO"
        }
    }
    
    func rotateOnce() {
        UIView.animateWithDuration(1.8,
            delay: 0.0,
            options: .CurveLinear,
            animations: {self.spinnerImage.transform = CGAffineTransformRotate(self.spinnerImage.transform, 3.1415926)},
            completion: {finished in self.rotateAgain()})
    }
    
    func rotateAgain() {
        UIView.animateWithDuration(1.8,
            delay: 0.0,
            options: .CurveLinear,
            animations: {self.spinnerImage.transform = CGAffineTransformRotate(self.spinnerImage.transform, 3.1415926)},
            completion: {finished in if self.rotating { self.rotateOnce() }})
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
