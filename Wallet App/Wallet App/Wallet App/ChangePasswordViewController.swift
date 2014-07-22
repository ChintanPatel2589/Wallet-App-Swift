//
//  ChangePasswordViewController.swift
//  Wallet App
//
//  Created by August Infotech on 7/17/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var btnCancel : UIButton
    @IBOutlet var btnDone : UIButton
    
    @IBOutlet var txtCurrentPass : UITextField
    @IBOutlet var txtNewPass : UITextField
    @IBOutlet var txtConfirmPass : UITextField
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController.navigationBar.translucent=false
        self.title = "Change Password"
        self.navigationController.navigationBar.barTintColor=UIColor(red: 252.0/255, green: 173.0/255, blue: 83.0/255, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController.navigationBar.titleTextAttributes = titleDict
        
        
        btnCancel.layer.borderWidth=2.5
        btnCancel.layer.borderColor=UIColor.whiteColor().CGColor
        btnCancel.layer.cornerRadius=btnCancel.frame.size.width/2
        
        btnDone.layer.borderWidth=2.5
        btnDone.layer.borderColor=UIColor.whiteColor().CGColor
        btnDone.layer.cornerRadius=btnDone.frame.size.width/2
        
        
        txtCurrentPass.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
   @IBAction func cancel()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func done()
    {
        if txtCurrentPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter Current Password.")
            self.txtCurrentPass.becomeFirstResponder()
            return
        }
        if txtNewPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter New Password.")
            self.txtNewPass.becomeFirstResponder()
            return
        }
        if txtConfirmPass.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0
        {
            self.alert("Alert", text: "Please enter Confirm Password.")
            self.txtConfirmPass.becomeFirstResponder()
            return
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("Password") as String) != txtCurrentPass.text
        {
            alert("Error", text: "Current Password does not Match.")
            return
        }
        if txtNewPass.text != txtConfirmPass.text
        {
            self.alert("Error", text: "Both password does not Match. Please enter correct password.")
            self.txtNewPass.becomeFirstResponder()
            return
        }
        NSUserDefaults.standardUserDefaults().setObject("", forKey: "Password")
        NSUserDefaults.standardUserDefaults().setObject(self.txtNewPass.text as String, forKey: "Password")
       // println(NSUserDefaults.standardUserDefaults().objectForKey("Password"))
        self.dismissViewControllerAnimated(true, completion: nil)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
