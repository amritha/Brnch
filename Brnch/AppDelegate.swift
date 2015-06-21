//
//  AppDelegate.swift
//  Brnch
//
//  Created by Josh Bisch on 6/9/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKShareKit
//import FBSDKLoginKit
import Fabric
import TwitterKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Parse
        Parse.setApplicationId("7MS5wZa6vItzAW7q1SWdDd2378pcxEvbOMSqE1SN", clientKey: "moNvruZg6zQ0kntm37s1kFzPuvbEMQsfcGcwiHA7")
        PFTwitterUtils.initializeWithConsumerKey("QwWA4h0UhPwC9RXVvOnsDpZa8",  consumerSecret:"jF8sQxw2XOZd5mPtx2btG5jOx0bv3dkL5B01OjGoJGcS1961Hc")
        //PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        //FBLoginView.self
        //FBProfilePictureView.self
        Fabric.with([Twitter()])
        
        if PFUser.currentUser() != nil{
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var vc = storyboard.instantiateViewControllerWithIdentifier("GetStartedViewController") as! UIViewController
            window?.rootViewController = vc
        }

        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }




}

