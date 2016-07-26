//
//  AccountSegue.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 7/25/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit

class AccountSegue: UIStoryboardSegue {

    override func perform() {
        var profileView = self.sourceViewController.view as! UIView
        var accountView = self.destinationViewController.view as! UIView
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        accountView.frame = CGRectMake(0.0, screenHeight - 400, screenWidth, screenHeight)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(accountView, aboveSubview: profileView)
        
        
        UIView.animateWithDuration(5.0, animations: { () -> Void in
            profileView.frame = CGRectOffset(profileView.frame, 0.0, -screenHeight)
            accountView.frame = CGRectOffset(accountView.frame, 0.0, -screenHeight)
            
        }) { (Finished) -> Void in
            print("you animated the segue!")
        }
    }
}
