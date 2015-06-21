//
//  WelcomeViewController.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/17/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit
import TwitterKit


class WelcomeViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
       
            // Show the signup or login screen
        

        let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            PFTwitterUtils.logInWithBlock {
                (user: PFUser?, error: NSError?) -> Void in
                if let user = user {
                    if user.isNew {
                        println("User signed up and logged in with Twitter!")
                    } else {
                        println("User logged in with Twitter!")
                    }
                    self.finishLogin()
                } else {
                    println("Uh oh. The user cancelled the Twitter login.")
                }
                
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    //FACEBOOK API YOU ARE DEAD TO ME
    @IBAction func didPressConnectFacebook(sender: AnyObject) {
        var permissions = ["public_profile", "user_friends", "email"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                
                var request = FBSDKGraphRequest(graphPath: "me", parameters: nil)
                request.startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    var userData = result as! NSDictionary
                
                    user["name"] = userData["name"] as! String
                    
                    user["gender"] = userData["gender"] as! String
                    
                    
                    //user["picURL"] = NSURL(fileURLWithPath: (userData["pictureURL"] as? String)!)!
                    
                    
                    user.saveInBackgroundWithBlock({ (status: Bool, error: NSError?) -> Void in
                        self.finishLogin()
                        
                    })
                })
//                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
//                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                if (!error) {
//                // result is a dictionary with the user's Facebook data
//                NSDictionary *userData = (NSDictionary *)result;
//                
//                NSString *facebookID = userData[@"id"];
//                NSString *name = userData[@"name"];
//                NSString *location = userData[@"location"][@"name"];
//                NSString *gender = userData[@"gender"];
//                NSString *birthday = userData[@"birthday"];
//                NSString *relationship = userData[@"relationship_status"];
//                
//                NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
//                
//                // Now add the data to the UI elements
//                // ...
//                }
//                }];
                
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        }
    }*/
    
    func finishLogin() {
        // Finally logged in.
        performSegueWithIdentifier("firstLoginSegue", sender: nil)
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
