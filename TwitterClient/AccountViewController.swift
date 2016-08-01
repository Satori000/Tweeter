//
//  AccountViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 7/22/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var users: [User]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello 2123")
        tableView.delegate = self
        tableView.dataSource = self
        print("hello 34")
        users = User.userList!
        print("hello 535")
        
        tableView.reloadData()
        print("hello 145")
        /* let window = UIApplication.sharedApplication().keyWindow
        if window!.rootViewController is AccountViewController {
            print("hellooooo view controller loaded")
            
            //do something if it's an instance of that class
        }
        
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight * 4)
        scrollView.delegate = self
        print(User.userList!.count)
       /* TwitterClient1.sharedInstance.addUserWithCompletion { (user: User?, error: NSError?) in
            if user != nil {
                print("hello")
                
            }
        }*/
        */
        //print(User.currentUser)
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let users = users {
            return users.count
        } else {
            return 0
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        TwitterClient1.sharedInstance.setUser((tableView.cellForRowAtIndexPath(indexPath) as! AccountCell).user!)
        print("hoy paloy")
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("woah")
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountCell", forIndexPath: indexPath) as! AccountCell
        print("hello tableview")
        let user = users![indexPath.row]
        print("why")
        cell.user = user
        
        print("arrived at cell")
        cell.screennameLabel.text = user.screenname
        
        print("hey i got here")
        cell.usernameLabel.text = user.name
        cell.profileImage.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        print("how")
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("you deleted the shit")
            NSUserDefaults.standardUserDefaults().removeObjectForKey((tableView.cellForRowAtIndexPath(indexPath) as! AccountCell).user!.name!)
            
            var newUserList = User.userList
            newUserList?.removeAtIndex(indexPath.row)
            User.userList = newUserList
            
            users = User.userList
            tableView.reloadData()
        }
    }

    @IBAction func onADD(sender: AnyObject) {
        TwitterClient1.sharedInstance.addUserWithCompletion { (user: User?, error: NSError?) in
            if user != nil {
                print("hello")
                
            }
        }
        print("you stink")
    }
    
  /*  @IBAction func onAdd(sender: AnyObject) {
        print("hey you pressed this")
        
        TwitterClient1.sharedInstance.addUserWithCompletion { (user: User?, error: NSError?) in
            if user != nil {
                print("hello")
            }
        }
        
    } */
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("hello")
        
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
