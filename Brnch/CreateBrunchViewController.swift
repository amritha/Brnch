//
//  CreateBrunchViewController.swift
//  Brnch
//
//  Created by MesoLaptop15 on 6/15/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class CreateBrunchViewController: UIViewController {
    
    // Add Crew Outlets
    @IBOutlet weak var addCrewView: UIView!
    @IBOutlet weak var addCrewContentView: UIView!
    @IBOutlet weak var addCrewButton: UIButton!
    
    // Add Location Outlets
    @IBOutlet weak var addLocationView: UIView!
    @IBOutlet weak var addLocationContentView: UIView!
    @IBOutlet weak var addLocationButton: UIButton!
    
    // Add Time Outlets
    @IBOutlet weak var addTimeView: UIView!
    @IBOutlet weak var addTimeContentView: UIView!
    @IBOutlet weak var addTimeButton: UIButton!
    
    // Outlet for All three
    @IBOutlet weak var crewLocationTimeView: UIView!
    
    // Tap Gesture Recognizers
    @IBOutlet var addCrewTapGesture: UITapGestureRecognizer!
    @IBOutlet var addLocationTapGesture: UITapGestureRecognizer!
    @IBOutlet var addTimeTapGesture: UITapGestureRecognizer!
    
  
    
    @IBOutlet weak var underlineView: UIView!
    
    
    // View Controller Variables
    var addCrewViewController: AddCrewViewController!
    var addLocationViewController: AddLocationViewController!
    var addTimeViewController: AddTimeViewController!
    
    // Original Centers
    var addCrewViewOriginalCenter: CGPoint!
    var addLocationViewOriginalCenter: CGPoint!
    var addTimeViewOriginalCenter: CGPoint!
    var crewLocationTimeViewOriginalCenter:CGPoint!
    
    var crewCenterX: CGFloat!
    var locationCenterX: CGFloat!
    var timeCenterX: CGFloat!
    
    var underlineCrewX: CGFloat!
    var underlineLocationX: CGFloat!
    var underlineTimeX: CGFloat!
    
    // Hidden Centers
    var addLocationViewHiddenCenter: CGPoint!
    var addLocationViewCenterOffset: CGFloat! = 520
    var addTimeViewHiddenCenter: CGPoint!
    var addTimeViewCenterOffset: CGFloat! = 450
    
    // Variables for Spring animations
    var springDuration: NSTimeInterval! = 0.6
    var springDamping: CGFloat! = 0.80
    var springVelocity: CGFloat! = 0
    
    var underlineSpringDuration: NSTimeInterval! = 0.3
    var underlineSpringDelay: NSTimeInterval! = 0
    
    var underlineSpringDurationTwo: NSTimeInterval! = 0.14
    var underlineSpringDelayTwo: NSTimeInterval! = 0.14
    
    var underlineTransformScaleX: CGFloat! = 3
    var underlineTransformScaleY: CGFloat! = 1
    
    // Keeping track of the location
    var currentStep: String!
    
    //Brnch PFObject
    var brnch : PFObject!
    
    var timer : NSTimer!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("doneButtonAppear"), userInfo: nil, repeats: true)
        

       
        
        // Instantiate View Controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
    
        
        addCrewViewController = storyboard.instantiateViewControllerWithIdentifier("AddCrewViewController") as! AddCrewViewController
        addLocationViewController = storyboard.instantiateViewControllerWithIdentifier("AddLocationViewController") as! AddLocationViewController
        addTimeViewController = storyboard.instantiateViewControllerWithIdentifier("AddTimeViewController") as! AddTimeViewController
        
        // Display the crew view controller in the crew content view
        displayContentController(addCrewViewController, destination: addCrewContentView)
        displayContentController(self.addLocationViewController, destination: self.addLocationContentView)
        displayContentController(self.addTimeViewController, destination: self.addTimeContentView)
        
        underlineCrewX = underlineView.center.x
        underlineLocationX = underlineView.center.x + 50
        underlineTimeX = underlineView.center.x + 100
        
        // Set all the original centers
        addCrewViewOriginalCenter = addCrewView.center
        addLocationViewOriginalCenter = addLocationView.center
        addTimeViewOriginalCenter = addTimeView.center
        crewLocationTimeViewOriginalCenter = crewLocationTimeView.center
        
        crewCenterX = crewLocationTimeView.center.x
        locationCenterX = crewLocationTimeView.center.x - 320
        timeCenterX = crewLocationTimeView.center.x - 640
        
        // Hide Location and Time view controllers
        //        addLocationView.center = addLocationViewHiddenCenter
        //        addTimeView.center = addTimeViewHiddenCenter
        
        // Turn off all tap gesture recognizers
        addCrewTapGesture.enabled = false
        addLocationTapGesture.enabled = false
        addTimeTapGesture.enabled = false
        
        currentStep = "Crew"
        // Do any additional setup after loading the view.
        
        //Create Brunch Object
        brnch = PFObject(className:"Brnch")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func displayContentController(content: UIViewController, destination: UIView) {
        // Displays a view controller in a specified view
        println("\(content) Visible")
        addChildViewController(content)
        destination.addSubview(content.view)
        content.didMoveToParentViewController(self)
        
    }
    
    func hideContentController(content: UIViewController, destination: UIView) {
        // Hides view controller from a specific view
        println("\(content) Hidden")
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
        
    }
    
    func moveUnderline(selection: CGFloat!) {
        

        UIView.animateWithDuration(underlineSpringDuration, delay: underlineSpringDelay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.underlineView.center = CGPoint(x: selection, y: self.underlineView.center.y)
            }) { (Bool) -> Void in
        }
        
        UIView.animateWithDuration(underlineSpringDuration, delay: underlineSpringDelay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.underlineView.transform = CGAffineTransformMakeScale(self.underlineTransformScaleX, 1)
            }) { (Bool) -> Void in
        }
        
        UIView.animateWithDuration(underlineSpringDurationTwo, delay: underlineSpringDelayTwo, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.underlineView.transform = CGAffineTransformMakeScale(1, 1)
            }) { (Bool) -> Void in
        }
    }
    
    func moveToView(selection: CGFloat!) {
        
        
    }
    
    func stepOneCrew() {
        // Step 1: Add your Crew
        println("Crew")
        
        
        if currentStep == "Crew" {
            println("Don't Move")
            
        } else {
            println("Moved")
            currentStep = "Crew"
            
            
            //        displayContentController(addCrewViewController, destination: addCrewContentView)
            //
            
            UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in
                
                self.crewLocationTimeView.center = CGPoint(x: self.crewCenterX, y: self.crewLocationTimeView.center.y)
                
                
                }) { (Bool) -> Void in
                    
                    //                self.hideContentController(self.addLocationViewController, destination: self.addLocationContentView)
                    //                self.hideContentController(self.addTimeViewController, destination: self.addTimeContentView)
            }
            
            // Underline Crew
            moveUnderline(underlineCrewX)
            
            
        }
        
        
    }
    
    
    func stepTwoLocation() {
        // Step 2: Change your Location
        self.addLocationViewController.brnch = brnch
        println("Location")
        
        
        if currentStep == "Location" {
            println("Don't Move")
            
        } else {
            println("Moved")
            currentStep = "Location"
            
            displayContentController(self.addLocationViewController, destination: self.addLocationContentView)
            
            
            UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in
                
                self.crewLocationTimeView.center = CGPoint(x: self.locationCenterX, y: self.crewLocationTimeView.center.y)
                
                }) { (Bool) -> Void in
                    
                    //                self.hideContentController(self.addCrewViewController, destination: self.addCrewContentView)
                    //                self.hideContentController(self.addTimeViewController, destination: self.addTimeContentView)
            }
            
            // Underline Location
            moveUnderline(underlineLocationX)

        
        }
        
        
    }
    
    func stepThreeTime() {
        
        self.addTimeViewController.brnch = brnch
        // Step 3: Change your time
        println("Time")
        
        
        if currentStep == "Time" {
            println("Don't Move")
            
        } else {
            println("Moved")
            currentStep = "Time"
            
            //        displayContentController(self.addTimeViewController, destination: self.addTimeContentView)
            //
            
            UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in
                
                self.crewLocationTimeView.center = CGPoint(x: self.timeCenterX, y: self.crewLocationTimeView.center.y)
                
                }) { (Bool) -> Void in
                    
                    //                self.hideContentController(self.addCrewViewController, destination: self.addCrewContentView)
                    //                self.hideContentController(self.addLocationViewController, destination: self.addLocationContentView)
            }
            
            // Underline Time
            moveUnderline(underlineTimeX)

            
        }
        
        
        
    }
    
    
    @IBAction func didPressCrewButton(sender: AnyObject) {
        println("Crew Next Button")
        stepOneCrew()
    }
    
    @IBAction func didPressLocationButton(sender: AnyObject) {
        println("Location Next Button")
        stepTwoLocation()
    }
    
    @IBAction func didPressTimeButton(sender: AnyObject) {
        println("Time Done Button")
        stepThreeTime()
        
        //        performSegueWithIdentifier("eventCreatedSegue", sender: nil)
        
    }
    
    
    @IBAction func didTapAddCrew(sender: AnyObject) {
        println("Back to Step 1")
        stepOneCrew()
        self.DismissKeyboard()
    }
    
    @IBAction func didTapAddLcation(sender: AnyObject) {
        println("Back to Step 2")
        stepTwoLocation()
        self.DismissKeyboard()
    }
    
    @IBAction func didTapAddTime(sender: AnyObject) {
        self.DismissKeyboard()
    }
    
    //How do we dismiss the keyboard?
    @IBAction func onGeneralTap(sender: AnyObject) {
        self.view.endEditing(true)
        println("Tapped")
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func doneButtonAppear(){
        if brnch["venue"] != nil && brnch["meet_time"] != nil
        {
            UIView.animateWithDuration(0.4, animations: {
                self.doneButton.frame = CGRect(x: 0, y: 509, width: 320, height: 60)
            })
            timer.invalidate()
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
