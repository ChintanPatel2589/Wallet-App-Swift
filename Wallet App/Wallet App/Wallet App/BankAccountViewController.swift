//
//  BankAccountViewController.swift
//  Wallet App
//
//  Created by august on 30/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class BankAccountViewController: UIViewController ,UITabBarDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate {
    
    
    //@IBOutlet var tabBar : UITabBar
    var dataDic = NSMutableDictionary()
    var isEdit = false
    var lastTextField = UITextField()
    
    // var app_obj = UIApplication.sharedApplication().delegate as AppDelegate
    
    @IBOutlet var scrollView : UIScrollView
    
    @IBOutlet var txtBankName : UITextField
    @IBOutlet var txtOwnerName : UITextField
    @IBOutlet var txtCategory : UITextField
    @IBOutlet var txtCurrency : UITextField
    @IBOutlet var txtNumber : UITextField
    @IBOutlet var txtBankCode :UITextField
    @IBOutlet var txtSwift :UITextField
    @IBOutlet var txtIBAN : UITextField
    @IBOutlet var txtPin : UITextField
    @IBOutlet var txtiBankingWebSite : UITextField
    @IBOutlet var txtAddress : UITextField
    @IBOutlet var txtPhone : UITextField
    @IBOutlet var txtViewNote : UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Bank Account"
        self.scrollView.contentSize=CGSizeMake(320, 670)
        self.navigationController.navigationBar.translucent=false
        self.navigationController.navigationBar.barTintColor=UIColor(red: 252.0/255, green: 173.0/255, blue: 83.0/255, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController.navigationBar.titleTextAttributes = titleDict
        // Do any additional setup after loading the view.
    if isEdit
    {
        var rightDoneBtn = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Bordered, target: self, action: "Edit")
        self.navigationItem.rightBarButtonItem=rightDoneBtn
        
        txtBankName.text=self.dataDic.valueForKey("BankName") as String
        txtOwnerName.text=self.dataDic.valueForKey("Name") as String
        txtCategory.text=self.dataDic.valueForKey("Category") as String
        txtCurrency.text=self.dataDic.valueForKey("Currency") as String
        txtNumber.text=self.dataDic.valueForKey("AccountNumber") as String
        txtBankCode.text=self.dataDic.valueForKey("BankCode") as String
        txtSwift.text=self.dataDic.valueForKey("Swift") as String
        txtIBAN.text=self.dataDic.valueForKey("IBAN") as String
        txtiBankingWebSite.text=self.dataDic.valueForKey("Website") as String
        txtAddress.text=self.dataDic.valueForKey("Address") as String
        txtPhone.text=self.dataDic.valueForKey("Phone") as String
        txtViewNote.text=self.dataDic.valueForKey("Notes") as String
        
        setTextFieldGrayColor() //Function call for set textfield editabel false and color
    
    }
    else
    {
        // Add new data
        var rightDoneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem=rightDoneBtn
        var leftDoneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancel")
        
        self.navigationItem.leftBarButtonItem=leftDoneBtn
        
    }
}

func alert(title:NSString, text:NSString)
{
    let alert = UIAlertView()
    alert.title = title
    alert.message = text
    alert.addButtonWithTitle("ok")
    alert.tag=101
    alert.delegate=self
    alert.show()
}
func Edit() //Start Editing and set alll text field editabel true
{
    var rightDoneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "Editdone")
    self.navigationItem.rightBarButtonItem=rightDoneBtn
    setTextfieldBlackColor() //Function for setting editable true and text color to black
}
func Editdone() //Editing Done Update Data
{
    var editResult = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"update bankAccount set BankName='%@',Name='%@',Category='%@',Currency='%@',AccountNumber='%@',BankCode='%@',Swift='%@',IBAN='%@',Pin='%@',Website='%@',Phone='%@',Address='%@',Notes='%@' where UID='%@'",txtBankName.text,txtOwnerName.text,txtCategory.text,txtCurrency.text,txtNumber.text,txtBankCode.text,txtSwift.text,txtIBAN.text,txtPin.text,txtiBankingWebSite.text,txtPhone.text,txtAddress.text,txtViewNote.text,self.dataDic.valueForKey("UID") as String))
    if editResult
    {
        self.lastTextField.resignFirstResponder()
        scrollView.setContentOffset(CGPointMake(0, -5), animated: true)
        setTextFieldGrayColor() //Function for set editable false and text color gray
        var rightDoneBtn = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Bordered, target: self, action: "Edit")
        self.navigationItem.rightBarButtonItem=rightDoneBtn
    }
    else
    {
        alert("Error", text: "ooppsss..Something getting Wrong. Please try Again with valid Data.")
    }
}

func done() //Save Data Insert New Data
{
    println("done")
 
    api_Database.createTable("CREATE TABLE IF NOT EXISTS bankAccount (UID TEXT,BankName TEXT, Name TEXT, Category TEXT, Currency TEXT, AccountNumber TEXT, BankCode TEXT, Swift TEXT, IBAN TEXT, PIN TEXT, Website TEXT, Phone TEXT,Address TEXT, Notes TEXT)", dbName: DATABASENAME)
    //api_Database.createTable("CREATE TABLE IF NOT EXISTS test (Name TEXT, City TEXT)", dbName: DATABASENAME)
    
    var result=api_Database.genericQueryforDatabase(DATABASENAME, query:NSString(format:"insert into bankAccount(UID,BankName,Name,Category,Currency,AccountNumber,BankCode,Swift,IBAN,Pin,Website,Phone,Address,Notes) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",NSUUID.UUID().UUIDString,txtBankName.text,txtOwnerName.text,txtCategory.text,txtCurrency.text,txtNumber.text,txtBankCode.text,txtSwift.text,txtIBAN.text,txtPin.text,txtiBankingWebSite.text,txtPhone.text,txtAddress.text,txtViewNote.text.stringByReplacingOccurrencesOfString("\'", withString: "\"", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)) as String)
    
    if result
    {
        self.dismissViewControllerAnimated(true, completion: {
            NSNotificationCenter.defaultCenter().postNotificationName("viewDismiss", object: nil)
            })
    }
    else
    {
        alert("Error", text: "ooppssss..Something getting wrong. Plase try again.")
    }
}
func cancel()
{
    println("cancel")
    self.dismissViewControllerAnimated(true, completion: nil)
    
//    self.dismissModalViewControllerAnimated(true)
}
func setTextFieldGrayColor()
{
    txtBankName.textColor=UIColor.grayColor()
    txtOwnerName.textColor=UIColor.grayColor()
    txtCategory.textColor=UIColor.grayColor()
    txtCurrency.textColor=UIColor.grayColor()
    txtNumber.textColor=UIColor.grayColor()
    txtBankCode.textColor=UIColor.grayColor()
    txtSwift.textColor=UIColor.grayColor()
    txtIBAN.textColor=UIColor.grayColor()
    txtPin.textColor=UIColor.grayColor()
    txtiBankingWebSite.textColor=UIColor.grayColor()
    txtPhone.textColor=UIColor.grayColor()
    txtAddress.textColor=UIColor.grayColor()
    txtViewNote.textColor=UIColor.grayColor()
    
    
    txtBankName.enabled=false
    txtOwnerName.enabled=false
    txtCategory.enabled=false
    txtCurrency.enabled=false
    txtNumber.enabled=false
    txtBankCode.enabled=false
    txtSwift.enabled=false
    txtIBAN.enabled=false
    txtPin.enabled=false
    txtiBankingWebSite.enabled=false
    txtPhone.enabled=false
    txtAddress.enabled=false
    txtViewNote.editable=false
    txtViewNote.selectable=false
}
func setTextfieldBlackColor()
{
    txtBankName.textColor=UIColor.blackColor()
    txtOwnerName.textColor=UIColor.blackColor()
    txtCategory.textColor=UIColor.blackColor()
    txtCurrency.textColor=UIColor.blackColor()
    txtNumber.textColor=UIColor.blackColor()
    txtBankCode.textColor=UIColor.blackColor()
    txtSwift.textColor=UIColor.blackColor()
    txtIBAN.textColor=UIColor.blackColor()
    txtPin.textColor=UIColor.blackColor()
    txtiBankingWebSite.textColor=UIColor.blackColor()
    txtPhone.textColor=UIColor.blackColor()
    txtAddress.textColor=UIColor.blackColor()
    txtViewNote.textColor=UIColor.blackColor()
    
    
    txtBankName.enabled=true
    txtOwnerName.enabled=true
    txtCategory.enabled=true
    txtCurrency.enabled=true
    txtNumber.enabled=true
    txtBankCode.enabled=true
    txtSwift.enabled=true
    txtIBAN.enabled=true
    txtPin.enabled=true
    txtiBankingWebSite.enabled=true
    txtPhone.enabled=true
    txtAddress.enabled=true
    txtViewNote.editable=true
    txtViewNote.selectable=true
}

func textFieldDidBeginEditing(textField: UITextField!)
{
    self.lastTextField = textField
    scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
//    if isEdit
//    {
//        if textField.tag == 1
//        {
//            return
//        }
//        if  textField.tag == 2 || textField.tag == 3 || textField.tag == 4
//        {
//            scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
//        }
//        else
//        {
//            scrollView.setContentOffset(CGPointMake(0, textField.center.y-60), animated: true)
//        }
//    }
//    else
//    {
//        if textField.tag == 1
//        {
//            return
//        }
//        if   textField.tag == 2 || textField.tag == 3 || textField.tag == 4
//        {
//            scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
//        }
//        else
//        {
//            scrollView.setContentOffset(CGPointMake(0, textField.center.y-60), animated: true)
//        }
//    }
}
func textFieldShouldReturn(textField: UITextField!) -> Bool
{
    textField.resignFirstResponder()
    scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    return true
}

func  textViewDidBeginEditing(textView: UITextView!)
{
    scrollView.setContentOffset(CGPointMake(0, textView.center.y-90), animated: true)
}
func textView(textView: UITextView!, shouldChangeTextInRange range: NSRange, replacementText text: String!) -> Bool
{
    if text == "\n"
    {
        textView.resignFirstResponder()
        scrollView.setContentOffset(CGPointMake(0, textView.frame.origin.y-330), animated: true)
        return  true
    }
    else
    {
        return true
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
