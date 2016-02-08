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
    
    
    var tweet: Tweet?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetText.text = "HELLO"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onFavorite(sender: UIButton) {
        
        var rowNum = sender.tag
        print("senderNum: \(rowNum)")
        
        var id = tweet!.id
        /*TwitterClient1.sharedInstance.favoriteWithParams(id) { (id, error) -> () in
            print("\(id)")
        }
        */
        
        
    }
    
    

}
