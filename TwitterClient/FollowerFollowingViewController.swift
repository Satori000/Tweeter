//
//  FollowerFollowingViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/14/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class FollowerFollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users: [User]?
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if let user = user {
            if let screenname = user.screenname {
                let dictionary = ["screen_name": screenname, "count": 200]
                TwitterClient1.sharedInstance.getFollowerWithParams(dictionary) { (users, error) -> () in
                    self.users = users
                    
                    self.tableView.reloadData()
                    
                }
                
                
            }

            
            
        }
        
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let users = users {
            print(users.count)
            
            return users.count
            
        } else {
            // print("hey this is 0")
            return 0
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowerCell", forIndexPath: indexPath) as! TweetCell
        
        var userProfileUrl = users![indexPath.row].profileImageUrl
        
        var imageUrl = NSURL(string: userProfileUrl!)
        
        cell.screenNameLabel.text = "@\(users![indexPath.row].name!)"
        
        cell.usernameLabel.text = users![indexPath.row].screenname
        cell.avi.setImageWithURL(imageUrl!)
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
