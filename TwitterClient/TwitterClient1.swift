//
//  TwitterClient1.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/6/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

let twitterConsumerKey = "BZFNoLkNOfGKMgZMQqgaMlogL"
let twitterConsumerSecret = "1Gtjbx8sQkxHBjqoUtvn9BnidrDmdkoBHRVQV12fDR2kPikWuD"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient1: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient1 {
        
        struct Static {
            static let instance = TwitterClient1(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            
            
            
        }
        
        return Static.instance
        
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion 
        
        TwitterClient1.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient1.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success:
            { (requestToken: BDBOAuth1Credential!) -> Void in
                print("got the request token")
                
                var authURL = NSURL(string:
                    "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("failed to get request token")
                self.loginCompletion?(user: nil, error: error)
                
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            TwitterClient1.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient1.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: { (NSProgress) -> Void in
                
                }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                    //print("user: \(response)")
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            TwitterClient1.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                
                for tweet in tweets {
                    print("text: \(tweet.text), created: \(tweet.createdAt)")
                    
                    
                }
                // print("home timeline \(response)")
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("failure to get home timeline")
                    
            })
            
            }) { (error: NSError!) -> Void in
                print("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
        

        
        
    }
    
}
