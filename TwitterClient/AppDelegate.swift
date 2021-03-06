//
//  AppDelegate.swift
//  TwitterClient
//
//  Created by Shakeeb Majid on 2/6/16.
//  Copyright © 2016 Shakeeb Majid. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        
        
        if User.currentUser != nil {
            
            //print("current user detected \(User.currentUser!.name)")
            let vc = storyboard.instantiateViewControllerWithIdentifier("navVc") as! UINavigationController
            
            vc.navigationBar.barTintColor = UIColor.clearColor()
            vc.tabBarItem.image = UIImage(named: "56470-200")

            let profileVC = storyboard.instantiateViewControllerWithIdentifier("profileVC") as! ProfileViewController
            profileVC.user = User.currentUser
            var profileTabImage = UIImage(named: "49968-200")
            //profileTabImage.scale = .5
            profileVC.tabBarItem.image = profileTabImage

            //var vc = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController") as UIViewController
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [vc, profileVC]
            window?.rootViewController = tabBarController
            
            window?.makeKeyAndVisible()
            
            
        }
        
        
        print("didfinishlaunchingwithoptions Ran")
        // Override point for customization after application launch.
        return true
    }
    
    
    
    func userDidLogout() {
        var vc = storyboard.instantiateInitialViewController()! as UIViewController
        
        window?.rootViewController = vc
        
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
         print("applicationWillResignActive")
        
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")

        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")

        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        print("applicationDidBecomeActive")

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        print("applicationWillTerminate")

        
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        TwitterClient1.sharedInstance.openURL(url)
        
        print("application")
        return true
    }


}

