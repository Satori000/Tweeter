//
//  User.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/6/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var bannerImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var followerCount: String?
    var followingCount: String?
    var tweetCount: String?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        followerCount = String(dictionary["followers_count"]!)
        followingCount = String(dictionary["friends_count"]!)
        tweetCount = String(dictionary["statuses_count"]!)
        bannerImageUrl = dictionary["profile_banner_url"] as? String
        
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient1.sharedInstance.requestSerializer.removeAccessToken()
        
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
        
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
        
                if data != nil {
                    do {
                        var dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch {
                        
                    }
        
                }
                //credit for code snippet goes to takashi wickes for JSON parsing
            }
        
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    var data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    
                }
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
}
