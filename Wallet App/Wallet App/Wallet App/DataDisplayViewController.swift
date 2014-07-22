//
//  DataDisplayViewController.swift
//  Wallet App
//
//  Created by august on 27/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class DataDisplayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITabBarDelegate,UIAlertViewDelegate {

    var selectedItem = ""
    var selectedIndex = 0
    var arrayDataList = NSMutableArray()
    @IBOutlet var tabBar : UITabBar
    var app_obj = UIApplication.sharedApplication().delegate as AppDelegate
    
    @IBOutlet var tblView : UITableView
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.selectedItem)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData", name: "viewDismiss", object: nil)
        var rightDoneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "add")
        self.navigationItem.rightBarButtonItem=rightDoneBtn
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        reloadTableData()
        self.navigationController.navigationBar.hidden=false
        UIApplication.sharedApplication().statusBarHidden=false
        self.navigationController.navigationBar.translucent=false
        
        var tabHome=UITabBarItem(title: "Home", image: UIImage(named: "TabHome.png"), tag: 1)
        var tabSetting=UITabBarItem(title: "Setting", image: UIImage(named: "TabSetting.png"), tag: 2)
        
        var ArryTabItems = [tabHome,tabSetting] as NSArray
        tabBar.setItems(ArryTabItems, animated: false)
        
        tabBar.selectedItem=ArryTabItems.objectAtIndex(0) as UITabBarItem
    }
    func reloadTableData()
    {
        if self.selectedItem as String == "Credit Card"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from creditCard") as NSMutableArray
        }
        else if self.selectedItem as String == "Bank Account"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from bankAccount") as NSMutableArray
        }
        else if self.selectedItem as String == "Web Login"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from webLogin") as NSMutableArray
        }
        else if self.selectedItem as String == "ID or Passport"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from IDPassport") as NSMutableArray
        }
        else if self.selectedItem as String == "Software License"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from SoftwareLicense") as NSMutableArray
        }
        else if self.selectedItem as String == "Secure Notes"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from SecureNotes") as NSMutableArray
        }
        else if self.selectedItem as String == "Debit Card"
        {
            arrayDataList=api_Database.selectDataFromDatabase(DATABASENAME, query: "select * from DebitCard") as NSMutableArray
        }
        //
        self.tblView.reloadData()
    }
    func add()
    {
        if self.selectedItem as String == "Credit Card"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("CreditCard") as CreditCardViewController
            AddData.isCreditCard=true
            var newTmpNav = UINavigationController(rootViewController: AddData)
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "Bank Account"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("BankAccount") as BankAccountViewController
            var newTmpNav = UINavigationController(rootViewController: AddData)
            
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "Web Login"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("WebLogin") as WebLoginViewController
            var newTmpNav = UINavigationController(rootViewController: AddData)
            
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "ID or Passport"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("Passport") as PassportViewController
            var newTmpNav = UINavigationController(rootViewController: AddData)
            
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "Software License"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("SoftwareLicense") as SoftwareLicenseViewController
            var newTmpNav = UINavigationController(rootViewController: AddData)
            
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "Secure Notes"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("SecureNotes") as SecureNotesViewController
            var newTmpNav = UINavigationController(rootViewController: AddData)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
        else if self.selectedItem as String == "Debit Card"
        {
            var AddData = self.storyboard.instantiateViewControllerWithIdentifier("CreditCard") as CreditCardViewController
            AddData.isCreditCard=false
            var newTmpNav = UINavigationController(rootViewController: AddData)
            //self.navigationController.presentModalViewController(newTmpNav, animated: true)
            self.navigationController.presentViewController(newTmpNav, animated: true, completion: nil)
        }
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
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        if arrayDataList.count > 0
        {
            return arrayDataList.count;
        }
        else
        {
            return 1;
        }
        
    }
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        
        var cellImage = UIImageView(image: UIImage(named: "list_background.png"))
        cell.backgroundView=cellImage
        
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var lblTitle:UILabel
        var lblDesc:UILabel
        var cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyCell")
            
            lblTitle=UILabel(frame: CGRectMake(10, 5, 200, 21))
            lblTitle.backgroundColor=UIColor.clearColor()
            lblTitle.tag=1
            lblTitle.textAlignment=NSTextAlignment.Left
            lblTitle.font=UIFont(name: "HelveticaNeue-Bold", size: 17)
            cell!.addSubview(lblTitle)
            
            lblDesc=UILabel(frame: CGRectMake(10, 20, 200, 21))
            lblDesc.backgroundColor=UIColor.clearColor()
            lblDesc.tag=2
            lblDesc.textColor=UIColor.lightGrayColor()
            lblDesc.textAlignment=NSTextAlignment.Left
            lblDesc.font=UIFont(name: "HelveticaNeue", size: 15)
            cell!.addSubview(lblDesc)
           
        }
        else
        {
            lblTitle=cell!.viewWithTag(1) as UILabel
            lblDesc=cell!.viewWithTag(2) as UILabel
        }
        
        if self.arrayDataList.count > 0
        {
            if self.selectedItem as String == "Web Login"
            {
                lblTitle.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("AccountName") as String
                lblDesc.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("Name") as String
            }
            else if self.selectedItem as String == "ID or Passport"
            {
                lblTitle.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("Name") as String
                lblDesc.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("Country") as String
            }
            else if self.selectedItem as String == "Software License"
            {
                lblTitle.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("SoftwareName") as String
                lblDesc.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("CompanyNmae") as String
            }
            else if self.selectedItem as String == "Secure Notes"
            {
                lblTitle.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("Name") as String
                lblDesc.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("OwnerName") as String
            }
            else
            {
                lblTitle.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("BankName") as String
                lblDesc.text=(arrayDataList.objectAtIndex(indexPath.row)).valueForKey("Name") as String
            }
            cell!.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle=UITableViewCellSelectionStyle.None
        }
        else
        {
            lblTitle.text = "No Data Found"
        }
        
        cell!.selectionStyle=UITableViewCellSelectionStyle.None
        return cell;
    }
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            self.selectedIndex=indexPath.row
            self.alert("Alert", text: "are you sure for delete?")
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if self.arrayDataList.count > 0
        {
            if self.selectedItem as String == "Credit Card"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("CreditCard") as CreditCardViewController
                AddDataOB.isEdit=true
                AddDataOB.isCreditCard=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "Bank Account"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("BankAccount") as BankAccountViewController
                AddDataOB.isEdit=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "Web Login"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("WebLogin") as WebLoginViewController
                AddDataOB.isEdit=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "ID or Passport"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("Passport") as PassportViewController
                AddDataOB.isEdit=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "Software License"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("SoftwareLicense") as SoftwareLicenseViewController
                AddDataOB.isEdit=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "Secure Notes"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("SecureNotes") as SecureNotesViewController
                AddDataOB.isEdit=true
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
            else if self.selectedItem as String == "Debit Card"
            {
                var AddDataOB=self.storyboard.instantiateViewControllerWithIdentifier("CreditCard") as CreditCardViewController
                AddDataOB.isEdit=true
                AddDataOB.isCreditCard=false
                AddDataOB.dataDic=self.arrayDataList.objectAtIndex(indexPath.row) as NSMutableDictionary
                var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
                self.navigationItem.backBarButtonItem=backBtn
                self.navigationController.pushViewController(AddDataOB, animated: true)
            }
        }
    }
    func alert(title:NSString, text:NSString)
    {
        var alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {action in
            println("confirm was tapped")
            
            if self.selectedItem as String == "Credit Card"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from creditCard where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "Bank Account"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from bankAccount where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "Web Login"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from webLogin where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "ID or Passport"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from IDPassport where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "Software License"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from SoftwareLicense where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "Secure Notes"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from SecureNotes where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            else if self.selectedItem as String == "Debit Card"
            {
                var result = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"delete from DebitCard where UID='%@'",(self.arrayDataList.objectAtIndex(self.selectedIndex).valueForKey("UID") as String))) as Bool
                if result
                {
                    self.arrayDataList.removeAllObjects()
                    self.reloadTableData()
                }
            }
            
            }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
//        var alert = UIAlertView()
//        alert.title = title
//        alert.message = text
//        alert.addButtonWithTitle("No")
//        alert.addButtonWithTitle("Yes")
//        alert.tag=101
//        alert.delegate=self
//        alert.show()
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        if alertView.tag==101
        {
            if buttonIndex==1
            {}
        }
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
