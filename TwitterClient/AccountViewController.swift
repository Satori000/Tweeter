//
//  AccountViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 7/22/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
         scrollView.contentSize = CGSize(width: 320, height: 1000)
        scrollView.delegate = self
        print(User.userList!.count)
        TwitterClient1.sharedInstance.addUserWithCompletion { (user: User?, error: NSError?) in
            if user != nil {
                print("hello")
                
            }
        }
        print(User.currentUser)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onADD(sender: AnyObject) {
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
