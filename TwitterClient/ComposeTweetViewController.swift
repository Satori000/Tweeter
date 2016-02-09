//
//  ComposeTweetViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/9/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var composeTextView: UITextView!
    
    @IBAction func onTweet(sender: AnyObject) {
        let tweet = composeTextView.text as? String
        let tweetDict = ["status": tweet!]
        TwitterClient1.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
