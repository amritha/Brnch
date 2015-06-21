//
//  AddLocationViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var foursquare: NSDictionary!
    var venues: [NSDictionary]! = [NSDictionary]()
    var locations: NSDictionary!
    var query: String!
    let clientId = "A2Y1X5HKMAGSCEEOWBORM2KN12SF4UR2ZENUXGTI0WVBDPPR%20"
    let clientSecret = "0TWO54EXQRI3JBRBGZ3H013X1Y25WR32R4RFDKWGN5QJPINS%20"
    var prevLocation : AddLocationTableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //searchField.becomeFirstResponder()
        //searchWithName("")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AddLocationTableViewCell") as! AddLocationTableViewCell
        var venue = venues[indexPath.row]
        
        var title = venue["name"] as! String
        
        //Address declarations
        var location = venue["location"] as! NSDictionary
        var address = location.valueForKeyPath("address") as? String
        
        
        //Category pics declarations
        var category = venue["categories"] as! NSArray
        var icons = category.valueForKeyPath("icon") as! NSArray
        
        var prefix = icons[0].valueForKeyPath("prefix") as! String
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
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddLocationTableViewCell
        
        if(prevLocation != nil){
            self.prevLocation.selected = false
            self.prevLocation.addButton.selected = false
        }
        
        prevLocation = cell
        prevLocation.selected = true
        prevLocation.addButton.selected = true
        /*brnch["venue"] = prevLocation.locationLabel.text
        brnch.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("saved location")
            } else {
                println("error location")
            }
        }*/

    }
    
    @IBAction func onSearchChanged(sender: AnyObject) {
        query = searchField.text
        delay(0.4)
            {
        
        self.searchWithName(self.query)
        }
        
    }
    func searchWithName(name: String){
        
        
        if let url = NSURL(string: "https://api.foursquare.com/v2/venues/search?client_id=\(self.clientId)&client_secret=\(self.clientSecret)&v=20130815%20&ll=40.7,-74%20&query=\(name)&near=San%20Francisco%2C%20CA") {
            
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
