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
   
   let defaults = NSUserDefaults.standardUserDefaults()
   let defaultTipCacheKey = "defaultTipPercentage"
   let subtotalTimestampCacheKey = "subtotalLastChanged"
   let subtotalCacheKey = "subtotal"
   
   var defaultTipValue = 0.0;
   let tipPercentages = [0.15, 0.18, 0.2]
   let subtotalDurationInSeconds = 10.0 * 60
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      self.defaultTipValue = 0.01 * self.defaults.doubleForKey(defaultTipCacheKey)
      self.subtotalTextField.becomeFirstResponder()
      populateBillSubtotal()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // Tapping on the main view will end edit mode
   @IBAction func onTapMainView(sender: AnyObject) {
      view.endEditing(true)
   }
   
   @IBAction func subtotalChanged(sender: AnyObject) {
      let subtotal = Double(subtotalTextField.text!) ?? 0
      let selectedPercentage = (tipControl.selectedSegmentIndex == -1) ?
         self.defaultTipValue : self.tipPercentages[tipControl.selectedSegmentIndex]
      let tip = subtotal * selectedPercentage
      
      tipLabel.text = String(format: "$%.2f", tip)
      totalLabel.text = String(format: "$%.2f", tip + subtotal)
      updateCacheWithNewSubtotal()
   }
   
   func updateCacheWithNewSubtotal() {
      self.defaults.setObject(NSDate() , forKey: self.subtotalTimestampCacheKey)
      self.defaults.setObject(subtotalTextField.text! , forKey: self.subtotalCacheKey)
      self.defaults.synchronize()
   }
   
   func populateBillSubtotal() {
      if let subtotalLastChanged = self.defaults.objectForKey(self.subtotalTimestampCacheKey)
         where self.isWithinTimeLimit(subtotalLastChanged as! NSDate) {
         subtotalTextField.text = self.defaults.stringForKey(self.subtotalCacheKey)
      }
   }
   
   func isWithinTimeLimit(lastChangedTimestamp: NSDate) -> Bool {
      let currentDateTimeAsInterval = NSDate().timeIntervalSinceReferenceDate
      return (currentDateTimeAsInterval - lastChangedTimestamp.timeIntervalSinceReferenceDate < self.subtotalDurationInSeconds)
   }
   

}

