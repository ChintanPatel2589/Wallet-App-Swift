//
//  HelpViewController.swift
//  Wallet App
//
//  Created by august on 26/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController,UITabBarDelegate {

    @IBOutlet var tabBar : UITabBar
    var app_obj = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Help"
        // Do any additional setup after loading the view.
    }
     override func viewWillAppear(animated: Bool)
     {
        var tabHome=UITabBarItem(title: "Home", image: UIImage(named: "TabHome.png"), tag: 1)
        var tabSetting=UITabBarItem(title: "Setting", image: UIImage(named: "TabSetting.png"), tag: 2)
        
        var ArryTabItems = [tabHome,tabSetting] as NSArray
        tabBar.setItems(ArryTabItems, animated: false)
        
        tabBar.selectedItem=ArryTabItems.objectAtIndex(1) as UITabBarItem
    }
    func tabBar(tabBar: UITabBar!, didSelectItem item: UITabBarItem!)
    {
        app_obj.tabTaggedTag=item.tag
        NSNotificationCenter.defaultCenter().postNotificationName("tabBarNotification", object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
