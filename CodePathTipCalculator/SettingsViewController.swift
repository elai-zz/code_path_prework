//
//  SettingsViewController.swift
//  CodePathTipCalculator
//
//  Created by Estella Lai on 9/9/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipAmountSlider: UISlider!
    @IBOutlet weak var cancelSettingsView: UIBarButtonItem!
    @IBOutlet weak var tipAmountField: UILabel!
    @IBOutlet weak var surpriseButton: UIButton!
    
    let defaultTipCacheKey = "defaultTipPercentage"
    let backgroundIDCacheKey = "background"
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // checks for default tip vale
        if let defaultTipValue = self.defaults.objectForKey(defaultTipCacheKey)?.integerValue {
            self.tipAmountSlider.value = Float(defaultTipValue)
            self.tipAmountField.text = String(defaultTipValue) + "%"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Randomly selects an integer between 1-3 as the background image ID.
     
     @param sender:AnyObject.
     
     @return Nil.
     */
    @IBAction func onSurpriseButtonClick(sender: AnyObject) {
        let backgroundNumber = Int(arc4random_uniform(3) + 1)
        self.defaults.setInteger(backgroundNumber, forKey: self.backgroundIDCacheKey)
        self.defaults.synchronize()
    }

    /**
     Returns to previous view.
     
     @param sender:AnyObject.
     
     @return Nil.
     */
    @IBAction func dismissView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     Updates default tip amount value and UI field displaying tip amount
     
     @param sender:AnyObject.
     
     @return Nil.
     */
    @IBAction func tipAmountChanged(sender: AnyObject) {
        let tipPercentage = Int(tipAmountSlider.value) ?? 0
        self.defaults.setInteger(tipPercentage, forKey: self.defaultTipCacheKey)
        self.defaults.synchronize()
        self.tipAmountField.text = String(tipPercentage) + "%"
    }

}
