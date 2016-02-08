//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/7/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class TweetsViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        TwitterClient1.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            print("hey")
            print(tweets![0].imageUrl)
            self.tableView.reloadData()
        })
        
        //print(tweets![0].text)

        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            print(tweets.count)
            return tweets.count
            
            
        } else {
            print("hey this is 0")
            return 0
   
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        
        
        let tweet = tweets![indexPath.row]
        
        
        
        let tweetString = tweet.text
        let tweetImageUrlString = tweet.imageUrl
        let tweetImageUrl = NSURL(string: tweetImageUrlString!)
        let tweetUserName = tweet.user!.name
        let tweetTimeElapsed = tweet.timeElapsedString
        let tweetFavoriteCount = tweet.favoriteCount
        let tweetRTCount = tweet.retweetCount
        
        cell.tweetText.text = tweetString
        
        cell.favoriteButton.tag = indexPath.row
        
        
        cell.avi.setImageWithURL(tweetImageUrl!)
        cell.usernameLabel.text = tweetUserName
        cell.timeElapsedLabel.text = tweetTimeElapsed
        cell.tweet = tweet
        cell.likeCountLabel.text = "\(tweetFavoriteCount)"
        cell.retweetCountLabel.text = "\(tweetRTCount!)"
        
        
        return cell
        
        
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
