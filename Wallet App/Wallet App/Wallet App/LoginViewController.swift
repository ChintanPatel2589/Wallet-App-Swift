//
//  LoginViewController.swift
//  Wallet App
//
//  Created by august on 25/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit
import MessageUI
class LoginViewController: UIViewController, MFMailComposeViewControllerDelegate,UITextFieldDelegate {

    @IBOutlet var txtPass : UITextField
    @IBOutlet var btnLogin : UIButton
    @IBOutlet var lblErrorMsg : UILabel
    var newLoginPass = ""
    var myMail: MFMailComposeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Login"
        
        btnLogin.layer.borderWidth=3
        btnLogin.layer.borderColor=UIColor.whiteColor().CGColor
        btnLogin.layer.cornerRadius=btnLogin.frame.size.width/2
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        txtPass.becomeFirstResponder()
        self.navigationController.navigationBar.hidden=false
        //self.tabBarController.tabBar.hidden=true
        UIApplication.sharedApplication().statusBarHidden=false
        //UIApplication.sharedApplication().statusBarHidden=false
        self.navigationController.navigationBar.translucent=false
       self.navigationController.navigationBar.barTintColor=UIColor(red: 252.0/255, green: 173.0/255, blue: 83.0/255, alpha: 1)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController.navigationBar.titleTextAttributes = titleDict
    }
    
    @IBAction func login()
    {
        if (NSUserDefaults.standardUserDefaults().valueForKey("Password") as String) == txtPass.text
        {
            //println("success")
            var homeOBj=self.storyboard.instantiateViewControllerWithIdentifier("Home") as HomeMenuViewController
            var backBtn = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: nil, action: nil)
            self.navigationItem.backBarButtonItem=backBtn
            homeOBj.navigationItem.hidesBackButton=true
            self.navigationController.pushViewController(homeOBj, animated: true)
            self.lblErrorMsg.hidden=true
        }
        else
        {
          self.lblErrorMsg.hidden=false
        }
    }
//    func textFieldDidBeginEditing(textField: UITextField!)
//    {
//        //tet.keyboardAppearance = UIKeyboardAppearanceDark;
//        textField.keyboardAppearance=UIKeyboardAppearance.Dark
//    }
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
    
    @IBAction func resetPassword()
    {
        self.newLoginPass=api_Database.generateRandomnumber()
        sendEmail(self.newLoginPass)
    }
    
    func sendEmail(newPassword:NSString)
    {
        if(MFMailComposeViewController.canSendMail()){
            myMail = MFMailComposeViewController()
            
            
            //myMail.mailComposeDelegate
            myMail.mailComposeDelegate = self
            // set the subject
            myMail.setSubject("Password Reset Wallet App iOS")
            
            //To recipients
            var email = NSUserDefaults.standardUserDefaults().objectForKey("Email") as String
            var toRecipients = [email]
            myMail.setToRecipients(toRecipients)
            
           
            
            //Add some text to the message body
            var sentfrom = NSString(format:"Hello, This is Your New Password for the Wallet App : %@ ",newPassword)
            myMail.setMessageBody(sentfrom, isHTML: true)
            
//            //Include an attachment
//            var image = UIImage(named: "Gimme.png")
//            var imageData = UIImageJPEGRepresentation(image, 1.0)
//            
//            myMail.addAttachmentData(imageData, mimeType: "image/jped", fileName:     "image")
            
            //Display the view controller
            self.presentViewController(myMail, animated: true, completion: nil)
        }
        else{
            alert("Alert", text: "Your device cannot send emails")
//            var alert = UIAlertController(title: "Alert", message: "Your device cannot send emails", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!,
        didFinishWithResult result: MFMailComposeResult,
        error: NSError!){
            
            switch(result.value){
            case MFMailComposeResultSent.value:
                println("Email sent")
                NSUserDefaults.standardUserDefaults().setObject("", forKey: "Password")
                NSUserDefaults.standardUserDefaults().setObject(self.newLoginPass, forKey: "Password")
                println(NSUserDefaults.standardUserDefaults().objectForKey("Password"))
                alert("Success", text: "your password successfully Reset and sent on your Email. Please Check your email.")
                
            default:
                println("Whoops")
                alert("error", text: "oooppss..Something getting wrong. Please try again.")
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
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
