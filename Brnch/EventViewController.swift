//
//  EventViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    
    var detailsTransition : DetailsTransition!
    var fadeTransition : FadeTransition!
    
    var foursquare : NSDictionary!
    var photos : NSDictionary!
    
    
    var timer = NSTimer()
    
    
    var imagePicker : UIImagePickerController!
    
    //TableView Stuff
    @IBOutlet weak var tableView: UITableView!
    
    //Parse Stuff
    var messages : [PFObject]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declare Table
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.messages.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
            
        //Declare Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        
        //Timer for messages query
        var messagesTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "queryTimer", userInfo: nil, repeats: true)
        
        messagesTimer.fire()

        
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
        
        // Keyboard shown or hidden
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Function to run the query that loads messages
    func queryTimer()
    {
        var query = PFQuery(className: "Message")
        
        query.findObjectsInBackgroundWithBlock{( results: [AnyObject]?, error: NSError?) -> Void in
            
            self.messages = results as! [PFObject]
            self.tableView.reloadData()
        }
        
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressCamera(sender: AnyObject) {
        
        //Declaring image picker
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self

        //Creating action sheet
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        //Choose Photo UIAlertAction
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        
        //Take Photo UIAlertAction
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .Camera
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        })
        
        //Cancel UIAlertAction
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        
        //Add actions to action sheet
        optionMenu.addAction(choosePhotoAction)
        optionMenu.addAction(takePhotoAction)
        optionMenu.addAction(cancelAction)
        
        //Present action sheet on click
        self.presentViewController(optionMenu, animated: true, completion: nil)
    
       
    }
    
    
    //Move Chat Window Up on Keyboard Appear
    func moveChatUp(){
        println("move chat up")
        UIView.animateWithDuration(0.4, animations: {
            self.chatView.frame = CGRect(x: 0, y: 240, width: 320, height: 50)
            //self.doneButtonImage.frame = self.doneButton.frame
        })
        
    }
    
    //Move Chat Window Down on Keyboard Disappear
    func moveChatDown() {
        println("move chat down")
        UIView.animateWithDuration(0.4, animations: {
            self.chatView.frame = CGRect(x: 0, y: 509, width: 320, height: 60)
            //self.doneButtonImage.frame = self.doneButton.frame
        })
        
    }
    
    
    func keyboardWillShow(notification: NSNotification!) {
        println("keyboard will show")
        moveChatUp()
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        println("keyboard will hide")
        
        moveChatDown()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ChatTableViewCell") as! ChatTableViewCell
        
        var message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String

        
        return cell
    }
    

    @IBAction func didPressSend(sender: AnyObject) {
        
        var message = PFObject(className: "Message")
        
        message["text"] = textField.text
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
            
            println("Saved the message")
        }
    }

    
    @IBAction func didPressView(sender: AnyObject) {
        // View Details button
        performSegueWithIdentifier("eventDetailsSegue", sender: self)
        
        
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
