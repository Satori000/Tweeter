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
 /*
    func followWithParams(params: NSDictionary?, completion: (status: String?, error: NSError?) -> ()) {
        
        POST("1.1/friendships/create.json", parameters: params, progress: {(operation: NSProgress) -> Void in }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("hey")
            print("\(response)")
            
            completion(status: status, error: nil)
            
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("follow not working")
                completion(status: nil, error: error)
        }
        
        
        
        
    } */
    
    /*func unFollowWithParams(params: NSDictionary?, completion: (status: String?, error: NSError?) -> ()) {
        
        POST("1.1/friendships/create.json", parameters: params, progress: {(operation: NSProgress) -> Void in }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //print("hey")
            print("\(response)")
            
            completion(status: status, error: nil)
            
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("follow not working")
                completion(status: nil, error: error)
        }

        
        
        
    }
*/

    
    func getTweetWithParams(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        let id = params!["id"] as! Int
        print(id)
        GET("1.1/statuses/show/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let tweet = Tweet(dictionary: response as! NSDictionary)
            
            //print(response as! NSDictionary)
            completion(tweet: tweet, error: nil)
             //print("tweet \(response)")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failure to get tweet")
                
                completion(tweet: nil, error: error)
        })
        
        
    }
    func getFollowerWithParams(params: NSDictionary?, completion: (users: [User]?, error: NSError?) -> ()) {
        
        GET("1.1/followers/list.json", parameters: params, progress: { (progress: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                let users = User.usersWithArray(response!["users"] as! [NSDictionary])
                print(response)
                print("user timeline request completed")
                completion(users: users, error: nil)
                
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("hey this user timeline request failed")
                completion(users: nil, error: error)
        }
        
        
        
    }

    func userTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/user_timeline.json", parameters: params, progress: { (progress: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                print("user timeline request completed")
                completion(tweets: tweets, error: nil)
                
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("hey this user timeline request failed")
                completion(tweets: nil, error: error)
        }

        
        
    }
    func favoritedTweetsWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/favorites/list.json", parameters: params, progress: { (progress: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                print("user timeline request completed")
                completion(tweets: tweets, error: nil)
                
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("hey this user timeline request failed")
                completion(tweets: nil, error: error)
        }
        
        
        
    }

    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        
       GET("1.1/statuses/home_timeline.json", parameters: params, progress: { (progress: NSProgress) -> Void in
        
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                print("home timeline request completed")
                print("home timeline \(response)")
                completion(tweets: tweets, error: nil)
                
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("hey this home timeline request failed")
                completion(tweets: nil, error: error)
        }
        
    
        
        
      /*  GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            //print("home timeline \(response)")
            completion(tweets: tweets, error: nil)
           
        }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            print("failure to get home timeline")
                
            completion(tweets: nil, error: error)
        })

        */
        
    }
    
    func tweetWithParams(params: NSDictionary?, completion: (status: String?, error: NSError?) -> ()) {
        
        POST("1.1/statuses/update.json", parameters: params, progress: {(operation: NSProgress) -> Void in }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let status = params!["status"] as! String
            //print("hey")
            //print("\(response)")
            
            completion(status: status, error: nil)
            
            
        }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            print("not working")
                completion(status: nil, error: error)
        }
        
        
        
        
    }
    
    func replyWithParams(params: NSDictionary?, completion: (status: String?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json", parameters: params, progress: {(operation: NSProgress) -> Void in }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let status = params!["status"] as! String
            
            completion(status: status, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                
                completion(status: nil, error: error)
        }
        
        
        
        
    }

    func favoriteWithParams(params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        
        POST("1.1/favorites/create.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                //success
            var id = params!["id"] as? Int
            
            
            completion(id: id, error: nil)
            
        }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
            completion(id: nil, error: error)
            
            
        }
        
        
        
    }
    
    func unFavoriteWithParams(params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        
        POST("1.1/favorites/destroy.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //success
            var id = params!["id"] as? Int
            
            
            completion(id: id, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                completion(id: nil, error: error)
                
                
        }
        
        
        
    }

    
    func retweetWithParams(params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        let id = params!["id"] as! Int
        
        
        
        POST("1.1/statuses/retweet/\(id).json", parameters: params, progress: { (operation: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let id = params!["id"] as? Int
                //print("retweet response: \(response)")
                completion(id: id, error: nil)
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                //print("retweet error: \(error)")
                completion(id: nil, error: error)
        }
    }
    
    func unRetweetWithParams(params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        let id = params!["id"] as! Int
        
        
        
        POST("1.1/statuses/unretweet/\(id).json", parameters: params, progress: { (operation: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let id = params!["id"] as? Int
                //print("retweet response: \(response)")
                completion(id: id, error: nil)
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                //print("retweet error: \(error)")
                completion(id: nil, error: error)
        }
    }

    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion 
        
        TwitterClient1.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient1.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success:
            { (requestToken: BDBOAuth1Credential!) -> Void in
                //print("got the request token")
                
                var authURL = NSURL(string:
                    "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                //print("failed to get request token")
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
                    //print("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                   // print("error getting user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            
            
            }) { (error: NSError!) -> Void in
                //print("failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
        

        
        
    }
    
}
