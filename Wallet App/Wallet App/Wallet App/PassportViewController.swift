//
//  PassportViewController.swift
//  Wallet App
//
//  Created by august on 02/07/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class PassportViewController: UIViewController,UITabBarDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate {

    var dataDic = NSMutableDictionary()
    var isEdit = false
    var lastTextField = UITextField()
    
    //Picker View
    var ArrayPickerItem : NSMutableArray = ["ID","Passport"]
    var isPickerViewUp = false
    @IBOutlet var pickerView : UIPickerView
    @IBOutlet var viewPicker : UIView
    //==========
    //Date Select View
    var isDatePickerViewUp = false
    @IBOutlet var viewDatePicker : UIView
    @IBOutlet var datePicker : UIDatePicker
    @IBOutlet var btnSelectDate : UIButton
    @IBOutlet var scrollView : UIScrollView
    
    @IBOutlet var txtName : UITextField
    @IBOutlet var txtCountry : UITextField
    @IBOutlet var txtCategory : UITextField
    @IBOutlet var txtExpirationMonth :UITextField
    @IBOutlet var txtExpirationYear :UITextField
    @IBOutlet var txtNumber : UITextField
    @IBOutlet var txtState : UITextField
    @IBOutlet var txtAddress1 : UITextField
    @IBOutlet var txtAddress2 : UITextField
    @IBOutlet var txtCity : UITextField
    @IBOutlet var txtZIP : UITextField
   // @IBOutlet var txtGender : UITextField
    //@IBOutlet var txtDOB : UITextField
    @IBOutlet var txtOccupation : UITextField
    @IBOutlet var txtCompany : UITextField
    @IBOutlet var txtViewNote : UITextView
    @IBOutlet var txtViewOther : UITextView
    
    @IBOutlet var btnGenderMale : UIButton
    @IBOutlet var btnGenderFemale : UIButton
    
    var gender = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController.navigationBar.translucent=false
        self.datePicker.maximumDate=NSDate()
        self.title="ID or Passport"
        self.scrollView.contentSize=CGSizeMake(320, 800)
        self.navigationController.navigationBar.barTintColor=UIColor(red: 252.0/255, green: 173.0/255, blue: 83.0/255, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController.navigationBar.titleTextAttributes = titleDict
        if isEdit
        {
           // println("Data: \(self.dataDic)")
            self.txtName.text=self.dataDic.valueForKey("Name") as String
            self.txtCountry.text=self.dataDic.valueForKey("Country") as String
            self.txtCategory.text=self.dataDic.valueForKey("Category") as String
            self.txtExpirationMonth.text=self.dataDic.valueForKey("ExpMonth") as String
            self.txtExpirationYear.text=self.dataDic.valueForKey("ExpYear") as String
            self.txtNumber.text=self.dataDic.valueForKey("IDNumber") as String
            self.txtState.text=self.dataDic.valueForKey("State") as String
            self.txtAddress1.text=self.dataDic.valueForKey("Address1") as String
            self.txtAddress2.text=self.dataDic.valueForKey("Address2") as String
            self.txtCity.text=self.dataDic.valueForKey("City") as String
            self.txtZIP.text=self.dataDic.valueForKey("ZIP") as String
           // self.txtGender.text=self.dataDic.valueForKey("Gender") as String
            
            self.txtOccupation.text=self.dataDic.valueForKey("Occupation") as String
            self.txtCompany.text=self.dataDic.valueForKey("Company") as String
            self.txtViewNote.text=self.dataDic.valueForKey("Notes") as String
            self.txtViewOther.text=self.dataDic.valueForKey("Other") as String
            
            if self.dataDic.valueForKey("DOB") as String != ""
            {
                self.btnSelectDate.setTitle(self.dataDic.valueForKey("DOB") as String, forState: UIControlState.Normal)
            }
            else
            {
                self.btnSelectDate.setTitle("Select DOB", forState: UIControlState.Normal)
            }
            if self.dataDic.valueForKey("Gender") as String != ""
            {
                if self.dataDic.valueForKey("Gender") as String == "Male"
                {
                    btnGenderMale.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
                    gender="Male"
                }
                else
                {
                    btnGenderFemale.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
                    gender="Female"
                }
            }
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
            self.btnSelectDate.setTitle("Select DOB", forState: UIControlState.Normal)
            self.navigationItem.leftBarButtonItem=leftDoneBtn
        }
    }
    override func viewWillAppear(animated: Bool)
    {
        var rViewDatepicker = self.viewPicker.frame as CGRect
        rViewDatepicker.origin.y = self.view.frame.size.height + 1
        self.viewPicker.frame=rViewDatepicker
    }
    
    @IBAction func btnGenderClicked(sender:UIButton)
    {
        if sender.tag == 0
        {//Male
            btnGenderFemale.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnGenderMale.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            gender="Male"
        }
        else
        {
            //Female
            btnGenderMale.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnGenderFemale.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            gender="Female"
        }
        
      
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
        var editResult = api_Database.genericQueryforDatabase(DATABASENAME, query: NSString(format:"update IDPassport set Name='%@',Country='%@',Category='%@',ExpMonth='%@',ExpYear='%@',IDNumber='%@',State='%@',Address1='%@',Address2='%@',City='%@',ZIP='%@',Gender='%@',DOB='%@',Occupation='%@',Company='%@',Other='%@',Notes='%@' where UID='%@'",txtName.text,txtCountry.text,txtCategory.text,txtExpirationMonth.text,txtExpirationYear.text,txtNumber.text,txtState.text,txtAddress1.text,txtAddress2.text,txtCity.text,txtZIP.text,self.gender,self.btnSelectDate.titleLabel.text,txtOccupation.text,txtCompany.text,txtViewOther.text,txtViewNote.text,self.dataDic.valueForKey("UID") as String))
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
        
        if txtName.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please enter Name")
            self.txtName.becomeFirstResponder()
            return
        }
        if txtCategory.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please select Category eg.Passport,ID")
            self.txtCategory.becomeFirstResponder()
            return
        }
        
        if txtExpirationMonth.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding).toIntMax() > 0
        {
            if txtExpirationMonth.text.toInt()  > 12 || txtExpirationMonth.text.toInt() <= 0
            {
                alert("Error", text: "Please enter Month between 1 to 12.")
                return
            }
        }
        else
        {
            self.alert("Error", text: "Please enter Expiration Month.")
            self.txtExpirationMonth.becomeFirstResponder()
            return
        }
        
        if txtExpirationYear.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please enter Expiration Year.")
            self.txtExpirationYear.becomeFirstResponder()
            return
        }
        if txtNumber.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please enter ID Number")
            self.txtNumber.becomeFirstResponder()
            return
        }
        if txtCountry.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please enter Country")
            self.txtCountry.becomeFirstResponder()
            return
        }
        if self.gender.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Error", text: "Please select your Gender.")
            return
        }
        if self.btnSelectDate.titleLabel.text == "Select DOB"
        {
                alert("Error", text: "Please Select DOB.")
                return
        }
        
        api_Database.createTable("CREATE TABLE IF NOT EXISTS IDPassport (UID TEXT,Name TEXT, Country TEXT, Category TEXT, ExpMonth TEXT, ExpYear TEXT, IDNumber TEXT, State TEXT,Address1 TEXT,Address2 TEXT,City TEXT,ZIP TEXT,Gender TEXT,DOB TEXT,Occupation TEXT,Company TEXT,Other  TEXT, Notes TEXT)", dbName: DATABASENAME)
        //api_Database.createTable("CREATE TABLE IF NOT EXISTS test (Name TEXT, City TEXT)", dbName: DATABASENAME)
        
        var result=api_Database.genericQueryforDatabase(DATABASENAME, query:NSString(format:"insert into IDPassport(UID,Name,Country,Category,ExpMonth,ExpYear,IDNumber,State,Address1,Address2,City,ZIP,Gender,DOB,Occupation,Company,Other,Notes) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",NSUUID.UUID().UUIDString,txtName.text,txtCountry.text,txtCategory.text,txtExpirationMonth.text,txtExpirationYear.text,txtNumber.text,txtState.text,txtAddress1.text,txtAddress2.text,txtCity.text,txtZIP.text,self.gender,self.btnSelectDate.titleLabel.text,txtOccupation.text,txtCompany.text,txtViewOther.text.stringByReplacingOccurrencesOfString("\'", withString: "\"", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil),txtViewNote.text.stringByReplacingOccurrencesOfString("\'", withString: "\"", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)) as String)
        
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
        txtName.textColor=UIColor.grayColor()
        txtCountry.textColor=UIColor.grayColor()
        txtCountry.textColor=UIColor.grayColor()
        txtExpirationMonth.textColor=UIColor.grayColor()
        txtExpirationYear.textColor=UIColor.grayColor()
        txtNumber.textColor=UIColor.grayColor()
        txtState.textColor=UIColor.grayColor()
        txtAddress1.textColor=UIColor.grayColor()
        txtAddress2.textColor=UIColor.grayColor()
        txtCity.textColor=UIColor.grayColor()
        txtZIP.textColor=UIColor.grayColor()
       // txtGender.textColor=UIColor.grayColor()
        //txtDOB.textColor=UIColor.grayColor()
        txtOccupation.textColor=UIColor.grayColor()
        txtCompany.textColor=UIColor.grayColor()
        txtViewOther.textColor=UIColor.grayColor()
        txtViewNote.textColor=UIColor.grayColor()
        
        
        txtName.enabled=false
        txtCountry.enabled=false
        txtCategory.enabled=false
        txtExpirationMonth.enabled=false
        txtExpirationYear.enabled=false
        txtNumber.enabled=false
        txtState.enabled=false
        txtAddress1.enabled=false
        txtAddress2.enabled=false
        txtCity.enabled=false
        txtZIP.enabled=false
       // txtGender.enabled=false
       // txtDOB.enabled=false
        txtOccupation.enabled=false
        txtCompany.enabled=false
       
        txtViewOther.editable=false
        txtViewOther.selectable=false
        txtViewNote.editable=false
        txtViewNote.selectable=false
        
        btnSelectDate.enabled=false
        btnGenderFemale.enabled=false
        btnGenderMale.enabled=false
    }
    func setTextfieldBlackColor()
    {
        txtName.textColor=UIColor.blackColor()
        txtCountry.textColor=UIColor.blackColor()
        txtCountry.textColor=UIColor.blackColor()
        txtExpirationMonth.textColor=UIColor.blackColor()
        txtExpirationYear.textColor=UIColor.blackColor()
        txtNumber.textColor=UIColor.blackColor()
        txtState.textColor=UIColor.blackColor()
        txtAddress1.textColor=UIColor.blackColor()
        txtAddress2.textColor=UIColor.blackColor()
        txtCity.textColor=UIColor.blackColor()
        txtZIP.textColor=UIColor.blackColor()
        //txtGender.textColor=UIColor.blackColor()
       // txtDOB.textColor=UIColor.blackColor()
        txtOccupation.textColor=UIColor.blackColor()
        txtCompany.textColor=UIColor.blackColor()
        txtViewOther.textColor=UIColor.blackColor()
        txtViewNote.textColor=UIColor.blackColor()
        
        
        txtName.enabled=true
        txtCountry.enabled=true
        txtCategory.enabled=true
        txtExpirationMonth.enabled=true
        txtExpirationYear.enabled=true
        txtNumber.enabled=true
        txtState.enabled=true
        txtAddress1.enabled=true
        txtAddress2.enabled=true
        txtCity.enabled=true
        txtZIP.enabled=true
       // txtGender.enabled=true
       // txtDOB.enabled=false
        txtOccupation.enabled=true
        txtCompany.enabled=true
        
        txtViewOther.editable=true
        txtViewOther.selectable=true
        txtViewNote.editable=true
        txtViewNote.selectable=true
        
        btnSelectDate.enabled=true
        btnGenderFemale.enabled=true
        btnGenderMale.enabled=true
    }
    
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        self.lastTextField = textField
        if textField.tag == 3
        {
            self.isPickerViewUp = true
            self.view.bringSubviewToFront(self.viewPicker)
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
                {
                    var rViewDatepicker = self.viewPicker.frame as CGRect
                    rViewDatepicker.origin.y = self.view.frame.size.height - 206
                    self.viewPicker.frame=rViewDatepicker
                },
                completion: {
                    (finished: Bool) in
                    textField.resignFirstResponder()
                    self.txtCategory.text="ID"
                    println("finished")
                });
        }
        else
        {
            if self.isPickerViewUp
            {
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
                    {
                        var rViewDatepicker = self.viewPicker.frame as CGRect
                        rViewDatepicker.origin.y = self.view.frame.size.height + 1
                        self.viewPicker.frame=rViewDatepicker
                        self.isPickerViewUp = false
                    },
                    completion: {
                        (finished: Bool) in
                        println("finished")
                    });
            }
        }
        if self.isDatePickerViewUp
        {
            self.tooBarCancel()
        }
        scrollView.setContentOffset(CGPointMake(0, textField.center.y-20), animated: true)

    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        return true
    }
    
    func  textViewDidBeginEditing(textView: UITextView!)
    {
        scrollView.setContentOffset(CGPointMake(0, textView.center.y-70), animated: true)
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
    @IBAction func btnSelectDOB()
    {
        if !self.isDatePickerViewUp
        {
            scrollView.setContentOffset(CGPointMake(0, btnSelectDate.center.y-87), animated: true)
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
                    self.isDatePickerViewUp = true
                    println("finished")
                });
        }
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
                self.isDatePickerViewUp = false
                println("finished")
            });
    }
    @IBAction func toolBarDone()
    {
        var DF = NSDateFormatter()
        DF.dateFormat="dd - MMM - yyyy"
        self.btnSelectDate.setTitle("\(DF.stringFromDate(self.datePicker.date))" , forState: UIControlState.Normal)
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewDatePicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height + 1
                self.viewDatePicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                self.isDatePickerViewUp = false
                println("finished")
            });
    }
    
    //==============================
    //PICKER VIEW
    //Picker View Method
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int
    {
        return self.ArrayPickerItem.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!{
        return self.ArrayPickerItem.objectAtIndex(row) as String
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        self.txtCategory.text = self.ArrayPickerItem.objectAtIndex(row) as String
    }
    
//    @IBAction func btnSelectDOB()
//    {
//        scrollView.setContentOffset(CGPointMake(0, txtCategory.center.y-87), animated: true)
//        self.view.bringSubviewToFront(self.viewPicker)
//        self.lastTextField.resignFirstResponder()
//        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
//            {
//                var rViewDatepicker = self.viewPicker.frame as CGRect
//                rViewDatepicker.origin.y = self.view.frame.size.height - 206
//                self.viewPicker.frame=rViewDatepicker
//            },
//            completion: {
//                (finished: Bool) in
//                println("finished")
//            });
//    }
    @IBAction func tooBarPickerViewCancel()
    {
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewPicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height + 1
                self.viewPicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                self.txtCategory.text = ""
                println("finished")
            });
    }
    @IBAction func toolBarPickerViewDone()
    {
        
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations:
            {
                var rViewDatepicker = self.viewPicker.frame as CGRect
                rViewDatepicker.origin.y = self.view.frame.size.height + 1
                self.viewPicker.frame=rViewDatepicker
            },
            completion: {
                (finished: Bool) in
                println("finished")
            });
    }
    
    //========================
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
