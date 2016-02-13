//
//  ComposeTweetViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/9/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit



class ComposeTweetViewController: UIViewController
{
    var tweet: Tweet?

    @IBOutlet weak var composeTextView: UITextView!
    
    
    @IBAction func onTweet(sender: AnyObject) {
        
        
        
        
        var tweetText = composeTextView.text as? String
        
        if let tweet = tweet {
            let statusId = tweet.id!
            let screenname = tweet.user?.screenname!
            tweetText = "@\(screenname!) \(tweetText!)"
            let tweetDict = ["status": tweetText!, "in_reply_to_status_id": statusId]
            TwitterClient1.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
                
            }
            //print("hey you just replied to id #\(statusId)")
            
        } else {
            let tweetDict = ["status": tweetText!]
            
            TwitterClient1.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
                
            }

        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            //print(self.tweet!.text)
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let tweetVC = segue.destinationViewController as! TweetsViewController
        
        //tweetVC.self.viewDidLoad()
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
