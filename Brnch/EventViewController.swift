//
//  EventViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/14/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var countDownLabel: UILabel!
    var foursquare : NSDictionary!
    var photos : NSDictionary!
    
    
    var timer = NSTimer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countDownLabel.text = String(counter)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
        
        //foursquare venue header
        
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
            
            var photoUrl = NSURL(string: "\(prefix[0])original\(suffix[0])")
            
            self.venueImageView.setImageWithURL(photoUrl)
            
            
            }
        
        
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCounter(){
    countDownLabel.text = String(counter++)
    
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
