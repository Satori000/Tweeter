//
//  TweetCell.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/7/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var avi: UIImageView!
    
    @IBOutlet weak var timeElapsedLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var retweetButtonImage: UIImageView!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    @IBOutlet weak var mediaImageView: UIImageView!
    
    
    var retweeted: Bool?
    var favorited: Bool?
    
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //tweetText.text = "HELLO"
        
        //let UITapRecognizer = UITapGestureRecognizer(target: self, action: "tappedImage:")
        //avi.userInteractionEnabled = true
       // UITapRecognizer.delegate = self
        //self.avi.addGestureRecognizer(UITapRecognizer)
        
                
        // Initialization code
    }
    
    func tappedImage(sender: AnyObject) {
        print("hey bitch")
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        //let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("profileVC") as! ProfileViewController
        //storyBoard.presentViewController(nextViewController, animated:true, completion:nil)
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onFavorite(sender: UIButton) {
        
        
        
        var id = tweet!.id
        var idDictionary = ["id": id!] as! NSDictionary
        
        TwitterClient1.sharedInstance.getTweetWithParams(idDictionary) { (tweet, error) -> () in
            self.tweet! = tweet!
            
        }
        
        id = self.tweet!.id
        
        
        //print("favorited: \(favorited)")
        
        if !favorited! {
            var favoriteCount = Int(self.likeCountLabel.text!)
            
            favoriteCount = favoriteCount! + 1
            
            if favoriteCount! == 0 {
                self.likeCountLabel.hidden = true
                
            } else {
                self.likeCountLabel.hidden = false
            }
            self.likeCountLabel.text = "\(favoriteCount!)"
            
            let image = UIImage(named: "like-action-on")
            self.favoriteButton.setImage(image!, forState: .Normal)
            self.favorited = !self.favorited!

            TwitterClient1.sharedInstance.favoriteWithParams(idDictionary) { (id, error) -> () in
                //print("\(id)")
            }
           // self.favorited = !self.favorited!
        } else {
            var favoriteCount = Int(self.likeCountLabel.text!)
            
            favoriteCount = favoriteCount! - 1
            
            if favoriteCount! == 0 {
                self.likeCountLabel.hidden = true
                
            } else {
                self.likeCountLabel.hidden = false
            }

            
            
            self.likeCountLabel.text = "\(favoriteCount!)"
            
            let image = UIImage(named: "like-action")
            self.favoriteButton.setImage(image!, forState: .Normal)
            self.favorited = !self.favorited!

            TwitterClient1.sharedInstance.unFavoriteWithParams(idDictionary) { (id, error) -> () in
                //print("\(id)")
            }
            //self.favorited = !self.favorited!
        }
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
        

        if !retweeted! {
            var retweetCount = Int(self.retweetCountLabel.text!)
            
            retweetCount = retweetCount! + 1
            
            if retweetCount! == 0 {
                self.retweetCountLabel.hidden = true
                
            } else {
                self.retweetCountLabel.hidden = false
            }
            

            self.retweetCountLabel.text = "\(retweetCount!)"
            
            let image = UIImage(named: "retweet-action-on")
            self.retweetButton.setImage(image!, forState: .Normal)
            self.retweeted = !self.retweeted!
            
            TwitterClient1.sharedInstance.retweetWithParams(idDictionary) { (id, error) -> () in
                
            }
            
        } else {
            var retweetCount = Int(self.retweetCountLabel.text!)
            
            retweetCount = retweetCount! - 1
            if retweetCount! == 0 {
                self.retweetCountLabel.hidden = true
                
            } else {
                self.retweetCountLabel.hidden = false
            }

            self.retweetCountLabel.text = "\(retweetCount!)"
            
            let image = UIImage(named: "retweet-action")
            self.retweetButton.setImage(image!, forState: .Normal)
            self.retweeted = !self.retweeted!
            
            TwitterClient1.sharedInstance.unRetweetWithParams(idDictionary, completion: { (id, error) -> () in
                
            })
        }
        
        
    }
    
    
    @IBAction func onReply(sender: AnyObject) {
        
        
        
        
        
        
    }
    
    
    
    

}
