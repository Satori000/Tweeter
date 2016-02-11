//
//  TweetDetailsViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/9/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailsViewController: UIViewController {
    
    
 
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screeennameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    
    var tweet: Tweet?
    
    
    
    
    @IBAction func onReply(sender: AnyObject) {
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        //var retweetCount = Int(self.retweetCountLabel.text!)
        //retweetCount = retweetCount! + 1
        var id = tweet!.id
        
        let idDictionary = ["id": id!]
        
        TwitterClient1.sharedInstance.getTweetWithParams(idDictionary) { (tweet, error) -> () in
            self.tweet! = tweet!
            
        }
        
        id = self.tweet!.id
        let retweeted = tweet?.retweeted
        
        if !retweeted! {
           // var retweetCount = Int(self.retweetCountLabel.text!)
            
            
            //retweetCount = retweetCount! + 1
           // self.retweetCountLabel.text = "\(retweetCount!)"
            
            let image = UIImage(named: "retweet-action-on")
            self.retweetButton.setImage(image!, forState: .Normal)
            //self.retweeted = !self.retweeted!
            
            TwitterClient1.sharedInstance.retweetWithParams(idDictionary) { (id, error) -> () in
                
            }
            
        } else {
           // var retweetCount = Int(self.retweetCountLabel.text!)
            
            
           // retweetCount = retweetCount! - 1
           // self.retweetCountLabel.text = "\(retweetCount!)"
            
            let image = UIImage(named: "retweet-action")
            self.retweetButton.setImage(image!, forState: .Normal)
            //self.retweeted = !self.retweeted!
            
            TwitterClient1.sharedInstance.unRetweetWithParams(idDictionary, completion: { (id, error) -> () in
                
            })
        }
    }
   
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        var id = tweet!.id
        var idDictionary = ["id": id!] as! NSDictionary
        
        TwitterClient1.sharedInstance.getTweetWithParams(idDictionary) { (tweet, error) -> () in
            self.tweet! = tweet!
            
        }
        
        id = self.tweet!.id
        let favorited = tweet!.favorited
        
        //print("favorited: \(favorited)")
        
        if !favorited! {
           // var favoriteCount = Int(self.likeCountLabel.text!)
           // favoriteCount = favoriteCount! + 1
           // self.likeCountLabel.text = "\(favoriteCount!)"
            
            let image = UIImage(named: "like-action-on")
            self.favoriteButton.setImage(image!, forState: .Normal)
           // self.favorited = !self.favorited!
            
            TwitterClient1.sharedInstance.favoriteWithParams(idDictionary) { (id, error) -> () in
                //print("\(id)")
            }
            // self.favorited = !self.favorited!
        } else {
            //var favoriteCount = Int(self.likeCountLabel.text!)
            //favoriteCount = favoriteCount! - 1
            //self.likeCountLabel.text = "\(favoriteCount!)"
            
            let image = UIImage(named: "like-action")
            self.favoriteButton.setImage(image!, forState: .Normal)
            //self.favorited = !self.favorited!
            
            TwitterClient1.sharedInstance.unFavoriteWithParams(idDictionary) { (id, error) -> () in
                //print("\(id)")
            }
            //self.favorited = !self.favorited!
        }

        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.dataSource = self
       // tableView.delegate = self
        let username = self.tweet!.user!.name
        let screenname = "@\(self.tweet!.screenname!)"
        let text = self.tweet!.text
        let date = self.tweet!.createdAtString
        let imageUrl = self.tweet!.imageUrl
        let retweetsCount = tweet!.retweetCount!
        let favoriteCount = tweet!.favoriteCount!
        
        if retweetsCount == 0 {
            retweetCountLabel.hidden = true
            //retweetCountLabel.removeFromSuperview()

            
        } else {
            retweetCountLabel.text = "\(retweetsCount) RETWEETS"
            
            
        }
        
        if favoriteCount == 0 {
            likeCountLabel.hidden = true
            //likeCountLabel.removeFromSuperview()
            
        } else {
            
            likeCountLabel.text = "\(favoriteCount) LIKES"
            
        }
        
        
        usernameLabel.text = username
        screeennameLabel.text = screenname
        tweetTextLabel.text = text
        dateAndTimeLabel.text = date
        profileImageView.setImageWithURL(NSURL(string: imageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        
        
        return cell
        
        
    } */

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let composeVC = segue.destinationViewController as! ComposeTweetViewController
        
        composeVC.tweet = self.tweet!
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

}
