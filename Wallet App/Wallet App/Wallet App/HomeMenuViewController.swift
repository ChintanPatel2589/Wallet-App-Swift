//
//  HomeMenuViewController.swift
//  Wallet App
//
//  Created by august on 25/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class HomeMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarDelegate {

    @IBOutlet var tblView : UITableView
    @IBOutlet var tabBar : UITabBar
    var arrayMenu = NSMutableArray()
    var app_obj = UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tabBarPressed", name: "tabBarNotification", object: nil)
        
        super.viewDidLoad()
        self.title="Home"
        arrayMenu = ["Credit Card","Debit Card","Bank Account","Web Login","ID or Passport","Software License","Secure Notes"]
   
        var logOutBtn = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Bordered, target: self, action:"logout")
        self.navigationItem.rightBarButtonItem=logOutBtn
        
        //TableView Animation
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveLinear, animations:
            {
                var rtblview = self.tblView.frame as CGRect
                rtblview.size.height=self.view.frame.size.height;
                self.tblView.frame=rtblview
            },
            completion: {
                (finished: Bool) in
                println("finished")
            });
    }
    
    func logout()
    {
        self.navigationController.popToRootViewControllerAnimated(true)
    }
    
    func tabBarPressed()
    {
        if self.app_obj.tabTaggedTag == 1
        {
            var homeOBj=self.storyboard.instantiateViewControllerWithIdentifier("Home") as HomeMenuViewController
            homeOBj.navigationItem.hidesBackButton=true
            self.navigationController.pushViewController(homeOBj, animated: false)
        }
        else
        {
            var settingOBJ=self.storyboard.instantiateViewControllerWithIdentifier("Setting") as SettingViewController
            settingOBJ.navigationItem.hidesBackButton=true
            self.navigationController.pushViewController(settingOBJ, animated: false)
        }
        //println(self.app_obj.tabTaggedTag)
    }
    func tabBar(tabBar: UITabBar!, didSelectItem item: UITabBarItem!)
    {
        app_obj.tabTaggedTag=item.tag
        NSNotificationCenter.defaultCenter().postNotificationName("tabBarNotification", object: nil)
    }
    override func viewWillAppear(animated: Bool)
    {
        
        self.navigationController.navigationBar.hidden=false
        UIApplication.sharedApplication().statusBarHidden=false
        self.navigationController.navigationBar.translucent=false
        
        var tabHome=UITabBarItem(title: "Home", image: UIImage(named: "TabHome.png"), tag: 1)
        var tabSetting=UITabBarItem(title: "Setting", image: UIImage(named: "TabSetting.png"), tag: 2)
        
        var ArryTabItems = [tabHome,tabSetting] as NSArray
        tabBar.setItems(ArryTabItems, animated: false)
        
        tabBar.selectedItem=ArryTabItems.objectAtIndex(0) as UITabBarItem
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return arrayMenu.count;
    }
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        var cellImage = UIImageView(image: UIImage(named: "list_background.png"))
        cell.backgroundView=cellImage
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var lblTitle:UILabel
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as? UITableViewCell
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyCell")
            lblTitle=UILabel(frame: CGRectMake(10, 15, 200, 21))
            lblTitle.backgroundColor=UIColor.clearColor()
            lblTitle.tag=1
            lblTitle.textAlignment=NSTextAlignment.Left
            
            cell!.addSubview(lblTitle)
        }
        else
        {
            lblTitle=cell!.viewWithTag(1) as UILabel
        }
        //lblTitle.font.setTitleTextAttributes(NSDictionary(objects: [UIFont(name: "Helvetica", size: 16.0)], forKeys: [NSFontAttributeName]), forState: UIControlState.Normal)
        lblTitle.text=self.arrayMenu.objectAtIndex(indexPath.row) as String
        lblTitle.font=UIFont(name: "HelveticaNeue", size: 17)
        
        cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell!.selectionStyle=UITableViewCellSelectionStyle.None
        return cell;
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
            var dataDisplauOBJ=self.storyboard.instantiateViewControllerWithIdentifier("DataDisplay") as DataDisplayViewController
            dataDisplauOBJ.selectedItem=arrayMenu.objectAtIndex(indexPath.row) as String
            dataDisplauOBJ.title=arrayMenu.objectAtIndex(indexPath.row) as String
            var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
            self.navigationItem.backBarButtonItem=backBtn
            self.navigationController.pushViewController(dataDisplauOBJ, animated: true)
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
