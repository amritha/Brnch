//
//  AddLocationViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var foursquare: NSDictionary!
    var venues: [NSDictionary]! = [NSDictionary]()
    var locations: NSDictionary!
    var query: String!
    let clientId = "A2Y1X5HKMAGSCEEOWBORM2KN12SF4UR2ZENUXGTI0WVBDPPR%20"
    let clientSecret = "0TWO54EXQRI3JBRBGZ3H013X1Y25WR32R4RFDKWGN5QJPINS%20"
    var prevLocation : AddLocationTableViewCell!
    var brnch : PFObject!

    var location: NSDictionary!
    var address: String!
    var category: NSArray!
    var icons: NSArray!
    var prefix: String!
    
    let locationManager = CLLocationManager()
    var locationLat : Double!
    var locationLong : Double!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //searchField.becomeFirstResponder()
        //self.searchWithName("brunch")
        
        //Get User's permission for location
        self.locationManager.requestWhenInUseAuthorization()
        
        //After user authorizes
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            locationLat = locationManager.location.coordinate.latitude
            locationLong = locationManager.location.coordinate.longitude
            
            println("latitude: \(locationLat)")
            println("longitude: \(locationLong)")

        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
        println(placemark.location.coordinate.latitude)
        println(placemark.location.coordinate.longitude)
        
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AddLocationTableViewCell") as! AddLocationTableViewCell
        var venue = venues[indexPath.row]
        
        var title = venue["name"] as! String
        
        //Address declarations
        location = venue["location"] as! NSDictionary
        address = location.valueForKeyPath("address") as? String
        
        
        //Category pics declarations
        category = venue["categories"] as! NSArray
        icons = category.valueForKeyPath("icon") as! NSArray
        
        prefix = icons[0].valueForKeyPath("prefix") as! String
        //var suffix = icon.valueForKeyPath("suffix") as! NSArray
        
        //println("\(prefix)")
        var iconUrlString = prefix
        
        
        var iconUrl = NSURL(string: "\(iconUrlString)bg_64.png")
        println("\(iconUrl)")

        
        cell.iconImageView.setImageWithURL(iconUrl)
        cell.locationLabel.text = title
        cell.addressLabel.text = address


        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddLocationTableViewCell
        
        // Storing previous location selected in order to unselect it when another is selected
        if(prevLocation != nil){
            self.prevLocation.selected = false
            self.prevLocation.addButton.selected = false
        }
        
        prevLocation = cell
        prevLocation.selected = true
        prevLocation.addButton.selected = true
        
        // Saves brnch event with selected venue
        brnch["venue"] = prevLocation.locationLabel.text
        if prevLocation.addressLabel.text != nil{
            brnch["address"] = prevLocation.addressLabel.text}
        brnch.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("saved location")
            } else {
                println("error location")
            }
        }


    }
    
    @IBAction func onSearchChanged(sender: AnyObject) {
        query = searchField.text
        delay(0.4)
            {
        
        self.searchWithName(self.query)
        }
        
    }
    func searchWithName(name: String){
        
        
        //if let url = NSURL(string: "https://api.foursquare.com/v2/venues/search?client_id=\(self.clientId)&client_secret=\(self.clientSecret)&v=20130815%20&ll=40.7,-74%20&query=\(name)&near=San%20Francisco%2C%20CA") {
        if let url = NSURL(string: "https://api.foursquare.com/v2/venues/search?client_id=\(self.clientId)&client_secret=\(self.clientSecret)&v=20130815%20&ll=40.7,-74%20&query=\(name)&ll=\(locationLat),\(locationLong)") {
            
            var request = NSURLRequest(URL: url)
            NSURLConnection.cancelPreviousPerformRequestsWithTarget(self)
            // once I do real time, cancel previous NSURL requests, maybe do it through temp variable
            
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                
                var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                
                self.foursquare = json["response"] as! NSDictionary
                self.venues = self.foursquare.valueForKeyPath("venues") as! [NSDictionary]
                
                //Categories
                
                
                
                //self.locations = self.venues valueForKeyPath("locations") as! NSDictionary
                
                //println("venues: \(self.venues)")
                //println("locations: \(self.locations)")
                
                //ALWAYS PUT THIS AT THE BOTTOM OF THE METHOD
                self.tableView.reloadData()
                
            }
            
            
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
