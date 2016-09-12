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
   let subtotalDurationInSeconds = 10.0 * 60
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.defaults.removeObjectForKey(self.backgroundIDCacheKey)
      // Do any additional setup after loading the view, typically from a nib.
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      self.defaultTipValue = 0.01 * self.defaults.doubleForKey(defaultTipCacheKey)
      self.subtotalTextField.becomeFirstResponder()
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
    Updates the tip and total amounts either using the selected segment index 
    or default tip value
    
    @param sender: AnyObject.
    
    @return Nil.
    */
   @IBAction func subtotalChanged(sender: AnyObject) {
      let subtotal = Double(subtotalTextField.text!) ?? 0
      let selectedPercentage = (tipControl.selectedSegmentIndex == -1) ?
         self.defaultTipValue : self.tipPercentages[tipControl.selectedSegmentIndex]
      let tip = subtotal * selectedPercentage
      tipLabel.text = String(formatWithLocale(tip))
      totalLabel.text = String(formatWithLocale(tip + subtotal))
      updateCacheWithNewSubtotal()
   }
   
   /**
    Updates NSUserDefaults with new subtotal value and timestamp
    
    @param Nil.
    
    @return Nil.
    */
   func updateCacheWithNewSubtotal() {
      self.defaults.setObject(NSDate() , forKey: self.subtotalTimestampCacheKey)
      self.defaults.setObject(subtotalTextField.text! , forKey: self.subtotalCacheKey)
      self.defaults.synchronize()
   }
   
   /**
    Populates the subtotal field if the last changed timestamp is within 
    specified duration and changes the tip amount
    
    @param Nil.
    
    @return Nil.
    */
   func populateBillSubtotal() {
      if let subtotalLastChanged = self.defaults.objectForKey(self.subtotalTimestampCacheKey)
         where self.isWithinTimeLimit(subtotalLastChanged as! NSDate) {
         subtotalTextField.text = self.defaults.stringForKey(self.subtotalCacheKey)
         self.subtotalChanged(self)
      }
   }
   
   /**
    Checks whether the last changed timestamp for Subtotal field is within the specified duration
    
    @param lastChangedTimestamp: NSDate.
    
    @return Bool.
    */
   func isWithinTimeLimit(lastChangedTimestamp: NSDate) -> Bool {
      let currentDateTimeAsInterval = NSDate().timeIntervalSinceReferenceDate
      return (currentDateTimeAsInterval - lastChangedTimestamp.timeIntervalSinceReferenceDate < self.subtotalDurationInSeconds)
   }
   
   /**
    Updates kittenImageView background image.
    
    @param Nil.
    
    @return Nil.
    */
   func populateKittenImageView() {
      let kittenImageFileName = getKittenImageFileName()
      if (kittenImageFileName != "") {
         UIGraphicsBeginImageContext(self.kittenImageView.frame.size)
         UIImage(named: kittenImageFileName)?.drawInRect(self.kittenImageView.bounds)
         let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         
         self.kittenImageView.alpha = 0
         UIView.animateWithDuration(1, animations: {
            self.kittenImageView.alpha = 0.4
         })
         
         self.kittenImageView.backgroundColor = UIColor(patternImage: image)
      }
   }
   
   /**
    Returns the appropriate background image filename.
    
    @param Nil.
    
    @return a String of the image filename.
    */
   func getKittenImageFileName() -> String {
      let backgroundImageValue = self.defaults.integerForKey(self.backgroundIDCacheKey) ?? 0
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

