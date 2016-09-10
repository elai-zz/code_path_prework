//
//  SettingsViewController.swift
//  CodePathTipCalculator
//
//  Created by Estella Lai on 9/9/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var cancelSettingsView: UIBarButtonItem!
    @IBOutlet weak var defaultTipPercentage: UITextField!
    let defaultTipCacheKey = "defaultTipPercentage"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTipValue = defaults.integerForKey(defaultTipCacheKey)
        if (defaultTipValue != 0) {
            defaultTipPercentage.text = String(defaultTipValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshUserDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipPercentage = Int(defaultTipPercentage.text!) ?? 0
        defaults.setInteger(tipPercentage, forKey: defaultTipCacheKey)
        defaults.synchronize()
    }

    @IBAction func dismissView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
