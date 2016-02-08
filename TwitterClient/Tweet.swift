//
//  Tweet.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/6/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var imageUrl: String?
    var timeElapsedString: String?
    var retweetCount: Int?
    var favoriteCount: Int?
    var id: Int?
    var screenname: String?
    
    
    init(dictionary: NSDictionary) {
        let userDictionary = dictionary["user"] as! NSDictionary
        user = User(dictionary: userDictionary)
        text = dictionary["text"] as? String
        imageUrl = userDictionary["profile_image_url"] as? String
        screenname = userDictionary["screen_name"] as? String 
        
        print(imageUrl)
        createdAtString = dictionary["created_at"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        //print("favorite count: \(favoriteCount)")
        id = dictionary["id"] as? Int
        
        
        print(dictionary)
        
        let timeElapsed = Int(0 - (createdAt?.timeIntervalSinceNow)!)
       
        
        
        //print("helllooooooo \(divide)")
        
        
        let secondsInMinute = 60
        let secondsInHour = secondsInMinute * 60
        let secondsInDay = secondsInHour * 24
        let secondsInMonth = secondsInDay * 30
        let monthsElapsed = timeElapsed/secondsInMonth
        let daysElapsed = timeElapsed/secondsInDay
        let hoursElapsed = timeElapsed/secondsInHour
        let minutesElapsed = timeElapsed/secondsInMinute
        let secondsElapsed = timeElapsed
        
        
        if monthsElapsed != 0 {
            timeElapsedString = "\(monthsElapsed)mon"
            
        } else if daysElapsed != 0 {
            timeElapsedString = "\(daysElapsed)d"

            
        } else if hoursElapsed != 0 {
            timeElapsedString = "\(hoursElapsed)h"

            
        } else if minutesElapsed != 0 {
            timeElapsedString = "\(minutesElapsed)m"

        } else {
            timeElapsedString = "\(secondsElapsed)s"
            
            
        }
        
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            
            tweets.append(Tweet(dictionary: dictionary))
            
        }
        
        return tweets
        
    }
}
