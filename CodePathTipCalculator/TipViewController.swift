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
   @IBOutlet weak var kittenImageView: UIImageView!
    
   let defaults = NSUserDefaults.standardUserDefaults()
   let defaultTipCacheKey = "defaultTipPercentage"
   let subtotalTimestampCacheKey = "subtotalLastChanged"
   let subtotalCacheKey = "subtotal"
   let backgroundIDCacheKey = "background"
   
   var defaultTipValue = 0.0;
   let tipPercentages = [0.15, 0.18, 0.2]
   let subtotalDurationInSeconds = 60.0 * 10 // 10 minutes
   
   override func viewDidLoad() {
      super.viewDidLoad()
      defaults.removeObjectForKey(backgroundIDCacheKey)
      // Do any additional setup after loading the view, typically from a nib.
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      defaultTipValue = 0.01 * defaults.doubleForKey(defaultTipCacheKey)
      subtotalTextField.becomeFirstResponder()
      populateBillSubtotal()
      populateKittenImageView()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   /**
    Exits out of keyboard when user taps anywhere in the view
    
    @param sender: AnyObject.
    
    @return Nil.
    */
   @IBAction func onTapMainView(sender: AnyObject) {
      view.endEditing(true)
   }
   
   /**
    Triggered by changing the subtotal field
    
    @param sender: AnyObject.
    
    @return Nil.
    */
   @IBAction func subtotalChanged(sender: AnyObject) {
      calculateTipTotal()
      updateCacheWithNewSubtotal()
   }
   
   /**
    Updates the tip and total amounts either using the selected segment index
    or default tip value
    
    @param Nil.
    
    @return Nil.
    */
   func calculateTipTotal() {
      let subtotal = Double(subtotalTextField.text!) ?? 0
      let selectedPercentage = (tipControl.selectedSegmentIndex == -1) ?
         defaultTipValue : tipPercentages[tipControl.selectedSegmentIndex]
      let tip = subtotal * selectedPercentage
      tipLabel.text = String(formatWithLocale(tip))
      totalLabel.text = String(formatWithLocale(tip + subtotal))
   }
   
   /**
    Updates NSUserDefaults with new subtotal value and timestamp
    
    @param Nil.
    
    @return Nil.
    */
   func updateCacheWithNewSubtotal() {
      defaults.setObject(NSDate() , forKey: subtotalTimestampCacheKey)
      defaults.setObject(subtotalTextField.text! , forKey: subtotalCacheKey)
      defaults.synchronize()
   }
   
   /**
    Populates the subtotal field if the last changed timestamp is within 
    specified duration and changes the tip amount
    
    @param Nil.
    
    @return Nil.
    */
   func populateBillSubtotal() {
      if let subtotalLastChanged = defaults.objectForKey(subtotalTimestampCacheKey)
         where isWithinTimeLimit(subtotalLastChanged as! NSDate) {
         subtotalTextField.text = defaults.stringForKey(subtotalCacheKey)
         calculateTipTotal()
      } else {
         subtotalTextField.text = ""
         tipLabel.text = ""
         totalLabel.text = ""
      }
   }
   
   /**
    Checks whether the last changed timestamp for Subtotal field is within the specified duration
    
    @param lastChangedTimestamp: NSDate.
    
    @return Bool.
    */
   func isWithinTimeLimit(lastChangedTimestamp: NSDate) -> Bool {
      let currentDateTimeAsInterval = NSDate().timeIntervalSinceReferenceDate
      return (currentDateTimeAsInterval - lastChangedTimestamp.timeIntervalSinceReferenceDate < subtotalDurationInSeconds)
   }
   
   /**
    Updates kittenImageView background image.
    
    @param Nil.
    
    @return Nil.
    */
   func populateKittenImageView() {
      let kittenImageFileName = getKittenImageFileName()
      if (kittenImageFileName != "") {
         UIGraphicsBeginImageContext(kittenImageView.frame.size)
         UIImage(named: kittenImageFileName)?.drawInRect(kittenImageView.bounds)
         let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         kittenImageView.alpha = 0
         UIView.animateWithDuration(1, animations: {
            self.kittenImageView.alpha = 0.4
         })
         
         kittenImageView.backgroundColor = UIColor(patternImage: image)
      }
   }
   
   /**
    Returns the appropriate background image filename.
    
    @param Nil.
    
    @return a String of the image filename.
    */
   func getKittenImageFileName() -> String {
      let backgroundImageValue = defaults.integerForKey(backgroundIDCacheKey) ?? 0
      if (backgroundImageValue == 0) {
         return ""
      } else {
         return String(format: "kitten_%i.jpg", backgroundImageValue)
      }
   }
   
   /**
    Converts a double into currency with system locale.
    
    @param amount:Double.
    
    @return a String of the amount value formated with system locale
    */
   func formatWithLocale(amount: Double) -> String {
      let formatter = NSNumberFormatter()
      formatter.numberStyle = .CurrencyStyle
      formatter.locale = NSLocale.currentLocale()
      return formatter.stringFromNumber(amount)!
   }

}

