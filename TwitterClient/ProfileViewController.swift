//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/12/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var tableControl: UISegmentedControl!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!

    @IBOutlet weak var tweetCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    var tweet: Tweet?
    var user: User?
    
    var tweets: [Tweet]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        scrollView.contentSize = CGSize(width: 320, height: 1000)

        scrollView.delegate = self
        
        let screenname = user?.screenname!
        let dictionary = ["screen_name": screenname!, "count": 150]
        TwitterClient1.sharedInstance.userTimelineWithParams(dictionary, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        
        //var subViewOfSegment: UIView = tableControl.subviews[0] as UIView
        //subViewOfSegment.tintColor = UIColor.blueColor()
        
        self.tableView.reloadData()

        
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        self.navigationController?.navigationBar.topItem!.title = ""
        usernameLabel.text = user!.name!
        screennameLabel.text = "@\(user!.screenname!)"
        descriptionLabel.text = user!.tagline!
        followingCountLabel.text = user!.followingCount!
        print("followers: \(user!.followerCount!) following: \(user!.followingCount!)")
        followerCountLabel.text = user!.followerCount!
        profileImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!)!)
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
        bannerImageView.setImageWithURL(NSURL(string: user!.bannerImageUrl!)!)
       // var image = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
      /*  var image = bannerImageView.image!.applyBlurWithRadius(
            CGFloat(5),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
        ) */
       tweetCountLabel.text = user!.tweetCount!

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tableController(sender: AnyObject) {
        let tableIndex = tableControl.selectedSegmentIndex
        
        if tableIndex == 0 {
            let screenname = user?.screenname!
            let dictionary = ["screen_name": screenname!, "count": 150]
            TwitterClient1.sharedInstance.userTimelineWithParams(dictionary, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
            
        } else {
            let screenname = user?.screenname!
            let dictionary = ["screen_name": screenname!, "count": 150]
            TwitterClient1.sharedInstance.favoritedTweetsWithParams(dictionary, completion: { (tweets, error) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            })
            
        }
            
                self.tableView.reloadData()
            

        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            print(tweets.count)
            return tweets.count
            
            
        } else {
            // print("hey this is 0")
            return 0
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userTimelineCell", forIndexPath: indexPath) as! TweetCell
        
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
        let favoritedImage = UIImage(named: "like-action-on")
        let retweetedImage = UIImage(named: "retweet-action-on")

        let imagert = UIImage(named: "retweet-action")
        
        cell.usernameLabel.text = tweetUserName
        cell.tweetText.text = tweetString
        cell.timeElapsedLabel.text = tweetTimeElapsed
        cell.screenNameLabel.text = "@\(tweetScreenname!)"
        cell.retweetButton.setImage(imagert!, forState: .Normal)
        cell.favorited = tweetFavorited
        cell.retweeted = tweetRetweeted
        cell.avi.setImageWithURL(tweetImageUrl!)
        if tweetFavoriteCount! == 0 {
            cell.likeCountLabel.hidden = true
            cell.likeCountLabel.text = "\(tweetFavoriteCount!)"
            //print(tweetFavoriteCount!)
        } else {
            
            cell.likeCountLabel.hidden = false
            cell.likeCountLabel.text = "\(tweetFavoriteCount!)"
            if tweetFavorited! {
                cell.favoriteButton.setImage(favoritedImage, forState: .Normal)
                
            }
            //print(tweetFavoriteCount!)
        }
        if tweetRTCount! == 0 {
            cell.retweetCountLabel.hidden = true
            cell.retweetCountLabel.text = "\(tweetRTCount!)"
        } else {
            cell.retweetCountLabel.hidden = false
            cell.retweetCountLabel.text = "\(tweetRTCount!)"
            if tweetRetweeted! {
                
                cell.retweetButton.setImage(retweetedImage, forState: .Normal)
            }
            
        }


       /* cell.favoriteButton.tag = indexPath.row
        
        
        
      
        
                cell.tweet = tweet
        
        
        
       
         */
        
        return cell

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Handle scroll behavior here
        
        bannerImageView.subviews.forEach({ $0.removeFromSuperview() })

        let scrollViewContentHeight = scrollView.contentSize.height
        
        let alphaValue = -(scrollView.contentOffset.y / 200)
        print("alphaValue: \(alphaValue) scrollViewoffset: \(scrollView.contentOffset.y)")
        // When the user has scrolled past the threshold, start requesting
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
        visualEffectView.frame = bannerImageView.bounds
        visualEffectView.alpha = alphaValue
        bannerImageView.addSubview(visualEffectView)
        //bannerImageView.frame = CGRect(x: 0, y: 0, width: 320, height: 80 - scrollView.contentOffset.y)
        bannerHeight.constant = 80 - scrollView.contentOffset.y
        print("height \(80 - scrollView.contentOffset.y)")
            // ... Code to load more results ...
            
        
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let followerVC = segue.destinationViewController as! FollowerFollowingViewController
        if let user = user {
            followerVC.user = user
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
