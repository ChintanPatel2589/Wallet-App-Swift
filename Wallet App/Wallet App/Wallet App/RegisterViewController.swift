//
//  RegisterViewController.swift
//  Wallet App
//
//  Created by august on 25/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class RegisterViewController : UIViewController,UITextFieldDelegate {

    @IBOutlet var txtFName : UITextField
    @IBOutlet var txtLName : UITextField
    @IBOutlet var txtEmail : UITextField
    @IBOutlet var txtPass : UITextField
    @IBOutlet var txtConfPass : UITextField
    @IBOutlet var btnRegister : UIButton
    
    var lastTextField = UITextField()
    var isKeyUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Register"
        
        btnRegister.layer.borderWidth=1
        btnRegister.layer.borderColor=UIColor.redColor().CGColor
        btnRegister.layer.cornerRadius=10
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"appBackToActiveState", name: "ResetKeyboard", object: nil)
        // Do any additional setup after loading the view.
    }
    func appBackToActiveState()
    {
        if isKeyUp
        {
            isKeyUp=false
            UIView.beginAnimations("UIVIEW", context: nil)
            var rviewFrame=self.view.frame
            rviewFrame.origin.y = +64
            self.view.frame=rviewFrame
            UIView.commitAnimations()
        }
        self.lastTextField.resignFirstResponder()
    }
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController.navigationBar.hidden=false
        UIApplication.sharedApplication().statusBarHidden=false
        self.navigationController.navigationBar.translucent=false
    }
    
    @IBAction func register()
    {
        
        if txtFName.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter First Name")
            hideKeyboard()
            self.txtFName.becomeFirstResponder()
            return
        }
        
        if txtLName.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter Last Name")
            hideKeyboard()
            self.txtLName.becomeFirstResponder()
            return
        }
        
        if txtEmail.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter Email")
            self.txtEmail.becomeFirstResponder()
            return
        }
        
        if txtPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter Password")
            self.txtPass.becomeFirstResponder()
            return
        }
        
        if txtPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) < 6
        {
            self.alert("Alert", text: "The password is too short: it must be at least 6 characters.")
            self.txtPass.becomeFirstResponder()
            return
        }
        if txtConfPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter confirm Password")
            self.txtConfPass.becomeFirstResponder()
            return
        }
        
        if !api_Database.validEmail(txtEmail.text)
        {
            self.alert("Error", text: "Please enter valid eMail ID.")
            self.txtEmail.becomeFirstResponder()
            return
        }
        
        if txtPass.text != txtConfPass.text
        {
            self.alert("Error", text: "Both password does not Match. Please enter correct password.")
            self.txtConfPass.becomeFirstResponder()
            return
        }
        saveData()
    }
    
    func saveData()
    {
        var fname = txtFName.text //as? String
        var lName = txtLName.text // as? String
        var pass = txtPass.text //as? String
        var email = txtEmail.text //as? String
        
         NSUserDefaults.standardUserDefaults().setObject(fname, forKey:"FirstName")
         NSUserDefaults.standardUserDefaults().setObject(lName, forKey:"LastName")
         NSUserDefaults.standardUserDefaults().setObject(email, forKey:"Email")
         NSUserDefaults.standardUserDefaults().setObject(pass, forKey:"Password")
         NSUserDefaults.standardUserDefaults().synchronize()
        
        fname = nil
        lName = nil
        pass = nil
        email = nil
        
        var homeOBj=self.storyboard.instantiateViewControllerWithIdentifier("Home") as HomeMenuViewController
        homeOBj.navigationItem.hidesBackButton=true
        self.navigationController.pushViewController(homeOBj, animated: true)
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
    
    func hideKeyboard()
    {
        if isKeyUp
        {
            isKeyUp=false
            UIView.beginAnimations("UIVIEW", context: nil)
            var rviewFrame=self.view.frame
            rviewFrame.origin.y = +64
            self.view.frame=rviewFrame
            UIView.commitAnimations()
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        
        if UIScreen.mainScreen().bounds.size.height == 568.0
        {
            if !isKeyUp
            {
                isKeyUp=true
                UIView.beginAnimations("UIVIEW", context: nil)
                var rviewFrame=self.view.frame
                rviewFrame.origin.y = -40
                self.view.frame=rviewFrame
                UIView.commitAnimations()
            }
        }
        else
        {
            if textField.tag == 1 || textField.tag == 2
            {
                if !isKeyUp
                {
                    isKeyUp=true
                    UIView.beginAnimations("UIVIEW", context: nil)
                    var rviewFrame=self.view.frame
                    rviewFrame.origin.y = -40
                    self.view.frame=rviewFrame
                    UIView.commitAnimations()
                }
            }
            else
            {
                if !isKeyUp
                {
                    isKeyUp=true
                    UIView.beginAnimations("UIVIEW", context: nil)
                    var rviewFrame=self.view.frame
                    rviewFrame.origin.y = -80
                    self.view.frame=rviewFrame
                    UIView.commitAnimations()
                }
                else
                {
                    //println("tag:\(self.lastTextField.tag)")
                    if self.lastTextField.tag == 1 || self.lastTextField.tag == 2 || self.lastTextField.tag == 3
                    {
                        isKeyUp=true
                        UIView.beginAnimations("UIVIEW", context: nil)
                        var rviewFrame=self.view.frame
                        rviewFrame.origin.y = -120
                        self.view.frame=rviewFrame
                        UIView.commitAnimations()
                    }
                }
            }
        }
        self.lastTextField=textField
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
            if isKeyUp
            {
                textField.resignFirstResponder()
                isKeyUp=false
                UIView.beginAnimations("UIVIEW", context: nil)
                var rviewFrame=self.view.frame
                rviewFrame.origin.y = +64
                self.view.frame=rviewFrame
                UIView.commitAnimations()
                return true
            }
            else
            {
                textField.resignFirstResponder()
                return false
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
