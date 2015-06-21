//
//  TwitterClient.swift
//  Brnch
//
//  Created by Amritha Prasad on 6/20/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit

let twitterConsumerKey = "QwWA4h0UhPwC9RXVvOnsDpZa8"
let twitterConsumerSecret = "jF8sQxw2XOZd5mPtx2btG5jOx0bv3dkL5B01OjGoJGcS1961Hc"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1Credential {
    class var sharedInstance: TwitterClient{
        struct Static{
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
   
}
