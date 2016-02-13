//
//  TweetsViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/7/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit



class TweetsViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var barItem: UINavigationItem!
    
    @IBOutlet weak var composeImage: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl?
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true

        
        self.refreshControl = UIRefreshControl()
        //self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        var dictionary = ["count": 200]
        TwitterClient1.sharedInstance.homeTimelineWithParams(dictionary, completion: { (tweets, error) -> () in
            self.tweets = tweets
            print("hey")
            //print(tweets![0].imageUrl)
            self.tableView.reloadData()
        })
        
        print("hello")
        //print(tweets![0].text)
        
                //composeImage.tintColor = UIColor.magentaColor()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
    }
    
    func refresh(sender: AnyObject) {
        
        let dictionary = ["count": 200]
        
        TwitterClient1.sharedInstance.homeTimelineWithParams(dictionary, completion: { (tweets, error) -> () in
            self.tweets = tweets
            //print("hey")
            //print(tweets![0].imageUrl)
            self.tableView.reloadData()
        })

        
        
        
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            //print(tweets.count)
            return tweets.count
            
            
        } else {
            //print("hey this is 0")
            return 0
   
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      // print("cell method accessed")
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        
        
        let tweet = tweets![indexPath.row]
        
        
        
        let tweetString = tweet.text
        let tweetImageUrlString = tweet.imageUrl
        let tweetImageUrl = NSURL(string: tweetImageUrlString!)
        let tweetUserName = tweet.user!.name
        let tweetTimeElapsed = tweet.timeElapsedString
        let tweetFavoriteCount = tweet.favoriteCount
        let tweetRTCount = tweet.retweetCount
        let tweetScreenname = tweet.screenname
        let tweetFavorited = tweet.favorited
        let tweetRetweeted = tweet.retweeted
        
        
        cell.tweetText.text = tweetString
        
        cell.favoriteButton.tag = indexPath.row
        
        let imagert = UIImage(named: "retweet-action")
        cell.retweetButton.setImage(imagert!, forState: .Normal)
        cell.avi.setImageWithURL(tweetImageUrl!)
        cell.usernameLabel.text = tweetUserName
        cell.timeElapsedLabel.text = tweetTimeElapsed
        cell.tweet = tweet
        cell.likeCountLabel.text = "\(tweetFavoriteCount!)"
        cell.retweetCountLabel.text = "\(tweetRTCount!)"
        cell.screenNameLabel.text = "@\(tweetScreenname!)"
        cell.favorited = tweetFavorited
        cell.retweeted = tweetRetweeted
        
        
        
        
        
        
        //print(indexPath.row)
        return cell
        
        
    }
    
    
    @IBAction func onTweet(sender: AnyObject) {
        
        let dictionary = ["status": "."]
        
        TwitterClient1.sharedInstance.tweetWithParams(dictionary) { (status, error) -> () in
            
            
            TwitterClient1.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets
                //print("hey")
                //print(tweets![0].imageUrl)
                self.tableView.reloadData()
            })

            
           // self.tableView.reloadData()
            
        } 

        
        
        
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var senderCell = sender!.superview!!.superview!
        
        if let sender = sender as? UITableViewCell {
            
            
            //print("congrats you just pressed a cell")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = self.tweets![indexPath!.row]
            let detailsViewController = segue.destinationViewController as! TweetDetailsViewController
            
            detailsViewController.tweet = tweet
            
        }
        else if let senderCell = senderCell as? UITableViewCell {
            
            
            if case let segue.identifier! = "profile" {
                let cell = sender?.superview!!.superview as! UITableViewCell
                let indexPath = tableView.indexPathForCell(cell)
                let user = self.tweets![indexPath!.row].user!
                
                let profileVC = segue.destinationViewController as! ProfileViewController
                profileVC.user = user
               // print("hey just went to profile")
                
                
                
            } else {
                let cell = sender?.superview!!.superview as! UITableViewCell
                let indexPath = tableView.indexPathForCell(cell)
                let tweet = self.tweets![indexPath!.row]
                //print(tweet.text)
                let composeVC = segue.destinationViewController as! ComposeTweetViewController
                
                composeVC.tweet = tweet
                print("hello you did not press a cell")
                

                
                
                
            }
            
                        // obj is not a string array
        }
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
