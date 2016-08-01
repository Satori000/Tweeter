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
var _userList = [] as! [User]
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
    //var accessToken: BDBOAuth1Credential?
    //static var userList = [] as! [User]

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
    
    init(dictionary: NSDictionary, token: BDBOAuth1Credential) {
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
    
    class func usersWithArray(array: [NSDictionary]) -> [User] {
        var users = [User]()
        
        for dictionary in array {
            users.append(User(dictionary: dictionary))
            
        }
        
        return users
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
               // let defaults = NSUserDefaults.standardUserDefaults()

                // defaults.removeObjectForKey(currentUserKey)
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                
               
        
                if data != nil {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                        //print("dictionary: \(dictionary)")
                        _currentUser = User(dictionary: dictionary as! NSDictionary)
                    } catch {
                        
                    }
        
                }
                //credit for code snippet goes to takashi wickes for JSON parsing
            }
        
            return _currentUser
        }
        
        set(user) {
            //let defaults = NSUserDefaults.standardUserDefaults()

            // defaults.removeObjectForKey(currentUserKey)
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: [])
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    
                }
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
    
    
    class var userList: [User]? {
        get {
            
            if _userList.count == 0 {
                let data = NSUserDefaults.standardUserDefaults().objectForKey("userList") as? NSData
                
                if data != nil {
                    do {
                        let dictionaryArray = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [NSDictionary]
                        //print("dictionary: \(dictionary)")
                        for dictionary in dictionaryArray {
                            _userList.append(User(dictionary: dictionary as! NSDictionary))
                            
                        }
                    } catch {
                        
                    }
                    
                }
                //credit for code snippet goes to takashi wickes for JSON parsing
            }
            
            return _userList as! [User]
        }
        
        set(userlist) {
            _userList = userlist!
            
            if _currentUser != nil {
                do {
                    var dictionaryArray = [] as! [NSDictionary]
                    for user in userList! {
                        dictionaryArray.append(user.dictionary)
                        print("hello: \(user.dictionary)")
                    }
                    let data = try NSJSONSerialization.dataWithJSONObject(dictionaryArray, options: [])
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: "userList")
                } catch {
                    
                }
                
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "userList")
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    
    
}
