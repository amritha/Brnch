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
    
    //our favorite places
    var favVenues: [NSDictionary]! = [NSDictionary]()
    var dosa: NSDictionary!
    var dosaInfo : NSDictionary!
    var brenda: NSDictionary!
    var brendaInfo : NSDictionary!
    var farmtable: NSDictionary!
    var farmtableInfo: NSDictionary!

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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y:0, width: 320, height: 40))
        headerView = UIView(frame: CGRect(x: 0, y:0, width: 320, height: 40))
        
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        var label = UILabel(frame: CGRect(x: 10, y:0, width: 300, height: 40))
        
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont(name: "OpenSans-Semibold", size: 12)
        
        if searchField.text == ""{
            label.text = "RECOMMENDED BRNCH SPOTS"
        }
            
        else{
            label.text = "SEARCH RESULTS"
            
        }
        
        
        headerView.addSubview(label)
        return headerView
    }

    
    @IBAction func onSearchChanged(sender: AnyObject) {
        query = searchField.text
        delay(0.4)
            {
        
        self.searchWithName(self.query)
        }
        
    }
    
    //Clicking in reveals favorite places
    @IBAction func onSearchBegan(sender: AnyObject) {
        if searchField.text == ""{
            query = searchField.text
            self.searchWithName(self.query)
        }
    }
    
    
    func searchWithName(name: String){
        
        
        if name == "" {
            println("Empty Livinnnnnn")
            
            //Dosa
            var venueId = "4aff8b4af964a520663922e3"
            var accessToken = "YTC10HGRAPCWLVP3VEHK122X23KEO30SHSUJ1GIPD4IIZQEE&v=20150614"
            
            var url = NSURL(string: "https://api.foursquare.com/v2/venues/\(venueId)/?oauth_token=\(accessToken)")!
            var request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.dosa = json["response"] as! NSDictionary
                
                self.dosaInfo = self.dosa.objectForKey("venue") as! NSDictionary
                //println("\(self.dosaInfo)")
                self.favVenues.append(self.dosaInfo)
                //println("\(self.favVenues)")
                self.venues = self.favVenues
                self.tableView.reloadData()
            }
            
            //Brenda's
            var venueId2 = "49f356f8f964a5208a6a1fe3"
            var accessToken2 = "YTC10HGRAPCWLVP3VEHK122X23KEO30SHSUJ1GIPD4IIZQEE&v=20150623"
            
            var url2 = NSURL(string: "https://api.foursquare.com/v2/venues/\(venueId2)/?oauth_token=\(accessToken2)")!
            var request2 = NSURLRequest(URL: url2)
            NSURLConnection.sendAsynchronousRequest(request2, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.brenda = json["response"] as! NSDictionary
                //println("\(self.brenda)")
                self.brendaInfo = self.brenda.objectForKey("venue") as! NSDictionary
                self.favVenues.append(self.brendaInfo)
                self.venues = self.favVenues
                self.tableView.reloadData()
            }
            
            //Farmtable
            var venueId3 = "4b008eadf964a520733f22e3"
            var accessToken3 = "YTC10HGRAPCWLVP3VEHK122X23KEO30SHSUJ1GIPD4IIZQEE&v=20150624"
            
            var url3 = NSURL(string: "https://api.foursquare.com/v2/venues/\(venueId3)/?oauth_token=\(accessToken3)")!
            var request3 = NSURLRequest(URL: url3)
            NSURLConnection.sendAsynchronousRequest(request3, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
                self.farmtable = json["response"] as! NSDictionary
                //println("\(self.brenda)")
                self.farmtableInfo = self.farmtable.objectForKey("venue") as! NSDictionary
                self.favVenues.append(self.farmtableInfo)
                //println("\(self.favVenues)")
                self.venues = self.favVenues
                self.tableView.reloadData()
            }
            
            
            
            
        }
            
        else{
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
