//
//  AboutAppViewController.swift
//  Wallet App
//
//  Created by August Infotech on 7/17/14.
//  Copyright (c) 2014 August infotech. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet var lblVersion : UILabel
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "About App"
        lblVersion.text = NSString(format: "Version %@", NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as String)

        // Do any additional setup after loading the view.
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
