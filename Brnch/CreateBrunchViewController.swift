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
    @IBOutlet weak var addCrewNextButton: UIButton!
    
    // Add Location Outlets
    @IBOutlet weak var addLocationView: UIView!
    @IBOutlet weak var addLocationContentView: UIView!
    @IBOutlet weak var addLocationNextButton: UIButton!
    
    // Add Time Outlets
    @IBOutlet weak var addTimeView: UIView!
    @IBOutlet weak var addTimeContentView: UIView!
    @IBOutlet weak var addTimeDoneButton: UIButton!
    
    // Tap Gesture Recognizers
    @IBOutlet var addCrewTapGesture: UITapGestureRecognizer!
    @IBOutlet var addLocationTapGesture: UITapGestureRecognizer!
    @IBOutlet var addTimeTapGesture: UITapGestureRecognizer!
    
    // View Controller Variables
    var addCrewViewController: AddCrewViewController!
    var addLocationViewController: AddLocationViewController!
    var addTimeViewController: AddTimeViewController!
    
    // Original Centers
    var addCrewViewOriginalCenter: CGPoint!
    var addLocationViewOriginalCenter: CGPoint!
    var addTimeViewOriginalCenter: CGPoint!
    
    // Hidden Centers
    var addLocationViewHiddenCenter: CGPoint!
    var addLocationViewCenterOffset: CGFloat! = 520
    var addTimeViewHiddenCenter: CGPoint!
    var addTimeViewCenterOffset: CGFloat! = 450
    
    // Variables for Spring animations
    var springDuration: NSTimeInterval! = 0.7
    var springDamping: CGFloat! = 0.80
    var springVelocity: CGFloat! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate View Controllers
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        addCrewViewController = storyboard.instantiateViewControllerWithIdentifier("AddCrewViewController") as! AddCrewViewController
        addLocationViewController = storyboard.instantiateViewControllerWithIdentifier("AddLocationViewController") as! AddLocationViewController
        addTimeViewController = storyboard.instantiateViewControllerWithIdentifier("AddTimeViewController") as! AddTimeViewController
        
        // Display the crew view controller in the crew content view
        displayContentController(addCrewViewController, destination: addCrewContentView)
        
        // Set all the original centers
        addCrewViewOriginalCenter = addCrewView.center
        addLocationViewOriginalCenter = addLocationView.center
        addTimeViewOriginalCenter = addTimeView.center
        
        // Define where Locattion and Time live when they are hidden
        addLocationViewHiddenCenter = CGPoint(x: addLocationViewOriginalCenter.x, y: addLocationViewOriginalCenter.y + addLocationViewCenterOffset)
        addTimeViewHiddenCenter = CGPoint(x: addTimeViewOriginalCenter.x, y: addTimeViewOriginalCenter.y + addTimeViewCenterOffset)
        
        // Hide Location and Time view controllers
        addLocationView.center = addLocationViewHiddenCenter
        addTimeView.center = addTimeViewHiddenCenter
        
        // Turn off all tap gesture recognizers
        addCrewTapGesture.enabled = false
        addLocationTapGesture.enabled = false
        addTimeTapGesture.enabled = false
        
        // Do any additional setup after loading the view.
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
    
    func stepOneCrew() {
        // Step 1: Add your Crew
        println("Crew")
        
        displayContentController(addCrewViewController, destination: addCrewContentView)
        
        addCrewTapGesture.enabled = false
        
        UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in
            self.addCrewView.center = self.addCrewViewOriginalCenter
            self.addLocationView.center = self.addLocationViewHiddenCenter
            self.addTimeView.center = self.addTimeViewHiddenCenter
            
            self.addCrewNextButton.alpha = 1
            self.addLocationNextButton.alpha = 0
            self.addTimeDoneButton.alpha = 0
            
            }) { (Bool) -> Void in
                self.hideContentController(self.addLocationViewController, destination: self.addLocationContentView)
                self.hideContentController(self.addTimeViewController, destination: self.addTimeContentView)
        }
        
        
    }
    
    func stepTwoLocation() {
        // Step 2: Change your Location
        println("Location")
        
        displayContentController(self.addLocationViewController, destination: self.addLocationContentView)
        
        addLocationTapGesture.enabled = false
        
        UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in            self.addCrewView.center = self.addCrewViewOriginalCenter
            self.addLocationView.center = self.addLocationViewOriginalCenter
            self.addTimeView.center = self.addTimeViewHiddenCenter
            
            self.addCrewNextButton.alpha = 0
            self.addLocationNextButton.alpha = 1
            self.addTimeDoneButton.alpha = 0
            
            }) { (Bool) -> Void in
                self.addCrewTapGesture.enabled = true
                self.hideContentController(self.addCrewViewController, destination: self.addCrewContentView)
                self.hideContentController(self.addTimeViewController, destination: self.addTimeContentView)
        }
        
    }
    
    func stepThreeTime() {
        // Step 3: Change your time
        println("Time")
        
        displayContentController(self.addTimeViewController, destination: self.addTimeContentView)
        
        UIView.animateWithDuration(springDuration, delay: 0, usingSpringWithDamping: self.springDamping, initialSpringVelocity: self.springVelocity, options: nil, animations: { () -> Void in            self.addCrewView.center = self.addCrewViewOriginalCenter
            self.addLocationView.center = self.addLocationViewOriginalCenter
            self.addTimeView.center = self.addTimeViewOriginalCenter
            
            self.addCrewNextButton.alpha = 0
            self.addLocationNextButton.alpha = 0
            self.addTimeDoneButton.alpha = 1
            
            }) { (Bool) -> Void in
                self.addCrewTapGesture.enabled = true
                self.addLocationTapGesture.enabled = true
                self.hideContentController(self.addCrewViewController, destination: self.addCrewContentView)
                self.hideContentController(self.addLocationViewController, destination: self.addLocationContentView)
        }
        
        
        
    }
    
    
    @IBAction func didPressAddCrewNextButton(sender: AnyObject) {
        println("Crew Next Button")
        stepTwoLocation()
    }
    
    @IBAction func didPressAddLocationNextButton(sender: AnyObject) {
        println("Location Next Button")
        stepThreeTime()
    }
    
    @IBAction func didPressAddTimeNextButton(sender: AnyObject) {
        println("Time Done Button")
        performSegueWithIdentifier("eventCreatedSegue", sender: nil)

    }
    
    
    @IBAction func didTapAddCrew(sender: AnyObject) {
        println("Back to Step 1")
        stepOneCrew()
    }
    
    @IBAction func didTapAddLcation(sender: AnyObject) {
        println("Back to Step 2")
        stepTwoLocation()
    }
    
    @IBAction func didTapAddTime(sender: AnyObject) {
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
