//
//  ComposeTweetViewController.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/9/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit



class ComposeTweetViewController: UIViewController, UITextViewDelegate
{
    var tweet: Tweet?

    @IBOutlet weak var composeTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBAction func onTweet(sender: AnyObject) {
        
        var tweetText = composeTextView.text as? String
        
        if let tweet = tweet {
            let statusId = tweet.id!
            let screenname = tweet.user?.screenname!
            tweetText = "@\(screenname!) \(tweetText!)"
            let tweetDict = ["status": tweetText!, "in_reply_to_status_id": statusId]
            TwitterClient1.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
                
            }
            //print("hey you just replied to id #\(statusId)")
        } else {
            let tweetDict = ["status": tweetText!]
            
            TwitterClient1.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
            }
        }
    }
    
   /* func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        //change the value of the label
        mylabel.text =  String(newLength)
        //you can save this value to a global var
        //myCounter = newLength
        //return true to allow the change, if you want to limit the number of characters in the text field use something like
        return newLength <= 25 // To just allow up to 25 characters
        return true
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeTextView.delegate = self
     
        
        if let tweet = self.tweet {
            //print(self.tweet!.text)
            
        }
        composeTextView.becomeFirstResponder()
        
        var timer =  NSTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "characterCounter", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func characterCounter() {
        var characterCount = composeTextView.text.characters.count
        
        var charactersLeft = 140 - characterCount
        
        countLabel.text = String(charactersLeft)
        
        if charactersLeft < 0 {
            composeTextView.deleteBackward()
            
        }
        
        
    }
    
   /* func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        var maxtext = 139
        //If the text is larger than the maxtext, the return is false
        return composeTextView.text.characters.count - range.length <= maxtext
        
    } */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        let tweetVC = segue.destinationViewController as! TweetsViewController
       
        tweetVC.reload = true
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
