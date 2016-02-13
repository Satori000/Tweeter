//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/12/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    var tweet: Tweet?
    var user: User?
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        usernameLabel.text = user!.name!
        screennameLabel.text = "@\(user!.screenname!)"
        descriptionLabel.text = user!.tagline!
        followingCountLabel.text = user!.followingCount!
        print("followers: \(user!.followerCount!) following: \(user!.followingCount!)")
        followerCountLabel.text = user!.followerCount!
        profileImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!)!)
        bannerImageView.setImageWithURL(NSURL(string: user!.bannerImageUrl!)!)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
