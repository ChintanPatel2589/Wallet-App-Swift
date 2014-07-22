//
//  ViewController.swift
//  Wallet App
//
//  Created by august on 25/06/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btnTraditional : UIButton
    @IBOutlet var btnTouchID : UIButton
    @IBOutlet var btnLogin : UIButton
    var isTraditional = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.layer.borderWidth=1
        btnLogin.layer.borderColor=UIColor.redColor().CGColor
        btnLogin.layer.cornerRadius=10
        // Do any additional setup after loading the view, typically from a nib.
    }
    
     override func viewWillAppear(animated: Bool)
     {
        self.navigationController.navigationBar.hidden=true 
        //self.tabBarController.tabBar.hidden=true
        UIApplication.sharedApplication().statusBarHidden=false
        btnTouchID.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
        btnTraditional.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
    }
    @IBAction func checlLoginType(sender:UIButton)
    {
        if sender.tag == 1
        {
            //Traditional type
            btnTouchID.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnTraditional.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            isTraditional=true
        }
        else
        {
            //Touch Id
            btnTraditional.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnTouchID.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            isTraditional=false
        }
    }
    @IBAction func checkLoginTypeLabel(sender:UITapGestureRecognizer)
    {
        if sender.view.tag == 11
        {
            //Traditional type
            btnTouchID.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnTraditional.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            isTraditional=true
        }
        else
        {
            //Touch Id
            btnTraditional.setImage(UIImage(named: "RadioUnChecked.png") as UIImage, forState: UIControlState.Normal)
            btnTouchID.setImage(UIImage(named: "RadioChecked.png") as UIImage, forState: UIControlState.Normal)
            isTraditional=false
        }
    }
    @IBAction func gotoRegisterPage()
    {
        if isTraditional
        {
            var regiOBJ=self.storyboard.instantiateViewControllerWithIdentifier("Register") as RegisterViewController
            self.navigationController.pushViewController(regiOBJ, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

