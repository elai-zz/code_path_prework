//
//  ViewController.swift
//  CodePathTipCalculator
//
//  Created by Estella Lai on 9/9/16.
//  Copyright © 2016 Estella Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var subtotalTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var defaultTipValue = 0.0;
    let defaultTipCacheKey = "defaultTipPercentage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        self.defaultTipValue = 0.01 * defaults.doubleForKey(defaultTipCacheKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Tapping on the main view will end edit mode
    @IBAction func onTapMainView(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.18, 0.2]
        let bill = Double(subtotalTextField.text!) ?? 0
        let selectedPercentage = (tipControl.selectedSegmentIndex == -1) ?
            self.defaultTipValue : tipPercentages[tipControl.selectedSegmentIndex]
        let tip = bill * selectedPercentage
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", tip + bill)
    }

}

