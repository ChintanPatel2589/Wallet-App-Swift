//
//  HelpViewController.swift
//  Wallet App
//
//  Created by august on 26/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITabBarDelegate,UITableViewDataSource {

    @IBOutlet var tabBar : UITabBar
    @IBOutlet var tblView : UITableView
    var app_obj = UIApplication.sharedApplication().delegate as AppDelegate
     let kCellIdentifier: String = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Setting"
       // self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.tblView.tableFooterView = UIView(frame: CGRectZero)
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
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 2
        }
        else
        {
             return 1
        }
    }
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
            return 0
        }
        else
        {
            return 10
        }
    }
//    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView!
//    {
//         var view = UIView(frame: CGRectMake(0, 0, 320, 0)) as UIView
//         return view
//    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: kCellIdentifier)
        }
       
       if indexPath.section == 0
       {
                if indexPath.row == 0
                {
                    cell!.textLabel.text="Change Password"
                }
                else
                {
                    cell!.textLabel.text="About App"
                }
        }
        else
        {
             cell!.textLabel.text="Help"
        }
        cell!.selectionStyle=UITableViewCellSelectionStyle.None
        cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell!.textLabel.textColor=UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        cell!.textLabel.font=UIFont.systemFontOfSize(17)
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if indexPath.section == 0
        {
            if indexPath.row == 0
            {
                var AddData = self.storyboard.instantiateViewControllerWithIdentifier("ChangePassword") as ChangePasswordViewController
                var newTmpNav = UINavigationController(rootViewController: AddData)
                self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
            }
            else
            {
                var AddData = self.storyboard.instantiateViewControllerWithIdentifier("AboutApp") as AboutAppViewController
                 self.navigationController.pushViewController(AddData, animated: true)
            }
        }
        else
        {
            
        }
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
