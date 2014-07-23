//
//  AppDelegate.swift
//  Wallet App
//
//  Created by august on 25/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var nav : UINavigationController?
     var tabTaggedTag = 0
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        // Override point for customization after application launch.
       
        if NSUserDefaults.standardUserDefaults().valueForKey("FirstName")
        {
            let homeOBJ = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as LoginViewController
             nav=UINavigationController(rootViewController: homeOBJ)
            if let window = self.window
            {
                window.rootViewController=nav
            }
        }
        else
        {
            let homeOBJ = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginType") as ViewController
             nav=UINavigationController(rootViewController: homeOBJ)
            
            if let window = self.window
            {
                window.rootViewController=nav
            }
        }
       return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        NSNotificationCenter.defaultCenter().postNotificationName("ResetKeyboard", object: nil)
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        if NSUserDefaults.standardUserDefaults().valueForKey("Login") as String != "NotRegister"
        {
            //println("regster")
            let homeOBJ = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login") as LoginViewController
            //[[self.navigationController viewControllers] lastObject];
           // var newTmpNav = UINavigationController(rootViewController: homeOBJ)

            if self.nav?.presentedViewController
            {
                self.nav?.presentedViewController.dismissViewControllerAnimated(false, completion: {
                    println("dismiss")
                    self.nav?.presentViewController(newTmpNav, animated: false, completion: nil)
                    })
            }
            else
            {
                self.nav?.presentViewController(newTmpNav, animated: false, completion: nil)
            }
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

