//
//  SoftwareLicenseViewController.swift
//  Wallet App
//
//  Created by August Infotech on 7/14/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class SoftwareLicenseViewController: UIViewController,UITabBarDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate {
    var isDatePickerUp = false
    var dataDic = NSMutableDictionary()
    var isEdit = false
    var lastTextField = UITextField()
    //Date Picker View
    @IBOutlet var viewDatePicker : UIView
    @IBOutlet var datePicker : UIDatePicker
    
    @IBOutlet var scrollView : UIScrollView
    
    @IBOutlet var txtSoftwareName : UITextField
    @IBOutlet var txtOwnerName : UITextField
    @IBOutlet var txtCompanyName : UITextField
    @IBOutlet var txtPurchaseDate : UITextField
    @IBOutlet var txtEmail : UITextField
    @IBOutlet var txtWebsite : UITextField
    @IBOutlet var txtLicenseKey : UITextField
    @IBOutlet var txtSupportEmail: UITextField
    @IBOutlet var txtPhone : UITextField
    @IBOutlet var txtPrice : UITextField
    @IBOutlet var txtViewNote : UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Software License"
        self.navigationController.navigationBar.translucent=false
        self.datePicker.maximumDate=NSDate()
        self.scrollView.contentSize=CGSizeMake(320, 800)
        self.navigationController.navigationBar.barTintColor=UIColor(red: 252.0/255, green: 173.0/255, blue: 83.0/255, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController.navigationBar.titleTextAttributes = titleDict
        if isEdit
        {
           
            self.txtSoftwareName.text=self.dataDic.valueForKey("SoftwareName") as String
            self.txtOwnerName.text=self.dataDic.valueForKey("OwnerName") as String
            self.txtCompanyName.text=self.dataDic.valueForKey("CompanyNmae") as String
            self.txtPurchaseDate.text=self.dataDic.valueForKey("PurchaseDate") as String
            self.txtEmail.text=self.dataDic.valueForKey("Email") as String
            self.txtWebsite.text=self.dataDic.valueForKey("LicenseKey") as String
            self.txtLicenseKey.text=self.dataDic.valueForKey("Website") as String
            self.txtSupportEmail.text=self.dataDic.valueForKey("SupportEmail") as String
            self.txtPhone.text=self.dataDic.valueForKey("Phone") as String
            self.txtPrice.text=self.dataDic.valueForKey("Price") as String
            self.txtViewNote.text=self.dataDic.valueForKey("Notes") as String
            
            var rightDoneBtn = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Bordered, target: self, action: "Edit")
            self.navigationItem.rightBarButtonItem=rightDoneBtn
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
        // Do any additional setup after loading the view.
    }
    func alert(title:NSString, text:NSString)
    {
        let alert = UIAlertView()
        alert.title = title
        alert.message = text
        alert.addButtonWithTitle("Ok")
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
        var editResult = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"update SoftwareLicense set SoftwareName='%@',OwnerName='%@',CompanyNmae='%@',PurchaseDate='%@',Email='%@',LicenseKey='%@',Website='%@',SupportEmail='%@',Phone='%@',Price='%@',Notes='%@' where UID='%@'",txtSoftwareName.text,txtOwnerName.text,txtCompanyName.text,txtPurchaseDate.text,txtEmail.text,txtLicenseKey.text,txtWebsite.text,txtSupportEmail.text,txtPhone.text,txtPrice.text,txtViewNote.text,self.dataDic.valueForKey("UID") as String))
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
        
        api_Database.createTable("CREATE TABLE IF NOT EXISTS SoftwareLicense (UID TEXT,SoftwareName TEXT, OwnerName TEXT, CompanyNmae TEXT, PurchaseDate TEXT, Email TEXT, LicenseKey TEXT, Website TEXT,SupportEmail TEXT,Phone TEXT,Price TEXT, Notes TEXT)", dbName: DATABASENAME)
        //api_Database.createTable("CREATE TABLE IF NOT EXISTS test (Name TEXT, City TEXT)", dbName: DATABASENAME)
        
        var result=api_Database.genericQueryforDatabase(DATABASENAME, query:NSString(format:"insert into SoftwareLicense(UID,SoftwareName,OwnerName,CompanyNmae,PurchaseDate,Email,LicenseKey,Website,SupportEmail,Phone,Price,Notes) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",NSUUID.UUID().UUIDString,txtSoftwareName.text,txtOwnerName.text,txtCompanyName.text,txtPurchaseDate.text,txtEmail.text,txtLicenseKey.text,txtWebsite.text,txtSupportEmail.text,txtPhone.text,txtPrice.text,txtViewNote.text.stringByReplacingOccurrencesOfString("\'", withString: "\"", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)) as String)
        
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
    }
    func setTextFieldGrayColor()
    {
        txtSoftwareName.textColor=UIColor.grayColor()
        txtOwnerName.textColor=UIColor.grayColor()
        txtCompanyName.textColor=UIColor.grayColor()
        txtPurchaseDate.textColor=UIColor.grayColor()
        txtEmail.textColor=UIColor.grayColor()
        txtLicenseKey.textColor=UIColor.grayColor()
        txtWebsite.textColor=UIColor.grayColor()
        txtSupportEmail.textColor=UIColor.grayColor()
        txtPhone.textColor=UIColor.grayColor()
        txtPrice.textColor=UIColor.grayColor()
        
        txtViewNote.textColor=UIColor.grayColor()
        
        
        txtSoftwareName.enabled=false
        txtOwnerName.enabled=false
        txtCompanyName.enabled=false
        
        txtPurchaseDate.enabled=false
        txtEmail.enabled=false
        txtLicenseKey.enabled=false
        txtWebsite.enabled=false
        txtSupportEmail.enabled=false
        txtPhone.enabled=false
        txtPrice.enabled=false
        
        txtViewNote.editable=false
        txtViewNote.selectable=false
        
        
    }
    func setTextfieldBlackColor()
    {
        txtSoftwareName.textColor=UIColor.blackColor()
        txtOwnerName.textColor=UIColor.blackColor()
        txtCompanyName.textColor=UIColor.blackColor()
        txtPurchaseDate.textColor=UIColor.blackColor()
        txtEmail.textColor=UIColor.blackColor()
        txtLicenseKey.textColor=UIColor.blackColor()
        txtWebsite.textColor=UIColor.blackColor()
        txtSupportEmail.textColor=UIColor.blackColor()
        txtPhone.textColor=UIColor.blackColor()
        txtPrice.textColor=UIColor.blackColor()
        
        txtViewNote.textColor=UIColor.blackColor()
        
        
        txtSoftwareName.enabled=true
        txtOwnerName.enabled=true
        txtCompanyName.enabled=true
        
        txtPurchaseDate.enabled=true
        txtEmail.enabled=true
        txtLicenseKey.enabled=true
        txtWebsite.enabled=true
        txtSupportEmail.enabled=true
        txtPhone.enabled=true
        txtPrice.enabled=true
        
        txtViewNote.editable=true
        txtViewNote.selectable=true
    }
    func textFieldShouldBeginEditing(textField: UITextField!) -> Bool
    {
        if textField.tag == 1004
        {
            
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
                {
                    var rViewDatepicker = self.viewDatePicker.frame as CGRect
                    rViewDatepicker.origin.y = self.view.frame.size.height - 206
                    self.viewDatePicker.frame=rViewDatepicker
                },
                completion: {
                    (finished: Bool) in
                    self.lastTextField.resignFirstResponder()
                    self.isDatePickerUp=true
                   // self.scrollView.userInteractionEnabled=false
                    println("finished")
                });
            return false
        }
        else
        {
            return true
        }
    }
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        self.lastTextField = textField
        if isEdit
        {
            if textField.tag == 1
            {
                return
            }
            if textField.tag == 1004
            {
                btnSelectDOB()
                return
            }
            if  textField.tag == 2 || textField.tag == 3
            {
                scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
            }
            else
            {
                scrollView.setContentOffset(CGPointMake(0, textField.center.y-60), animated: true)
            }
        }
        else
        {
           
            if self.isDatePickerUp
            {
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
                    {
                        var rViewDatepicker = self.viewDatePicker.frame as CGRect
                        rViewDatepicker.origin.y = self.view.frame.size.height + 1
                        self.viewDatePicker.frame=rViewDatepicker
                    },
                    completion: {
                        (finished: Bool) in
                        self.isDatePickerUp=false
                        println("finished")
                    });
            }
                scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
            
          
//            if  textField.tag == 2 || textField.tag == 3 || textField.tag == 4
//            {
//                scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)
//            }
//            else
//            {
//                scrollView.setContentOffset(CGPointMake(0, textField.center.y-87), animated: true)
//            }
        }
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
    
    /// Date Picker View Method
     func btnSelectDOB()
    {
       // scrollView.setContentOffset(CGPointMake(0, txtPurchaseDate.center.y-87), animated: true)
        self.view.bringSubviewToFront(self.viewDatePicker)
        self.lastTextField.resignFirstResponder()
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewDatePicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height - 206
                self.viewDatePicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                
                println("finished")
            });
    }
    @IBAction func tooBarCancel()
    {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewDatePicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height + 1
                self.viewDatePicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                println("finished")
                self.scrollView.userInteractionEnabled=true
                self.lastTextField.resignFirstResponder()
            });
    }
    @IBAction func toolBarDone()
    {
        var DF = NSDateFormatter()
        DF.dateFormat="dd - MMM - yyyy"
        self.txtPurchaseDate.text = DF.stringFromDate(self.datePicker.date)
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewDatePicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height + 1
                self.viewDatePicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                self.lastTextField.resignFirstResponder()
                self.scrollView.userInteractionEnabled=true
                println("finished")
            });
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
