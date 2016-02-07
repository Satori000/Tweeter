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

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
        
                    do {
                        // Start by converting the NSData to a dictionary - a dictionary for the entire response
                        if let dictionary = try NSJSONSerialization.JSONObjectWithData(data!,
                            options:NSJSONReadingOptions(rawValue:0)) as? [String:AnyObject] {
        
                                // Dip inside the response to find the "movies" key and get the array of movies
                        }
                    } catch {
                        print("Error parsing JSON")
                    }
        
                    //var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
        
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
                
            }
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }
    
}












# Project 4 - *TwitterClient*

**TwitterClient** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **3** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow
- [ ] User can view last 20 tweets from their home timeline
- [ ] The current signed in user will be persisted across restarts
- [ ] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.

The following **optional** features are implemented:

- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] User can pull to refresh.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

## License

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
