//
//  CustomRightViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates configuring various types of controls as the right
  bar item of the navigation bar.
 */

import UIKit

@objc(CustomRightViewController)
class CustomRightViewController: UIViewController {
    
    //| ----------------------------------------------------------------------------
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    //| ----------------------------------------------------------------------------
    //! IBAction for the segemented control.
    //
    @IBAction func changeRightBarItem(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // Add a custom add button as the nav bar's custom right view
            let addButton = UIBarButtonItem(title: NSLocalizedString("AddTitle", comment: ""),
                style: UIBarButtonItemStyle.Bordered,
                target: self,
                action: "action:")
            self.navigationItem.rightBarButtonItem = addButton
        } else if sender.selectedSegmentIndex == 1 {
            // add our custom image button as the nav bar's custom right view
            let addButton = UIBarButtonItem(image: UIImage(named: "Email"),
                style: UIBarButtonItemStyle.Bordered, target: self, action: "action:")
            self.navigationItem.rightBarButtonItem = addButton
        } else if sender.selectedSegmentIndex == 2 {
            // "Segmented" control to the right
            let segmentedControl = UISegmentedControl(items: [
                UIImage(named: "UpArrow")!,
                UIImage(named: "DownArrow")!,
                ])
            
            segmentedControl.addTarget(self, action: "action:", forControlEvents: .ValueChanged)
            segmentedControl.frame = CGRectMake(0, 0, 90, 30.0)
            segmentedControl.momentary = true
            
            let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
            
            self.navigationItem.rightBarButtonItem = segmentBarItem
        }
    }
    
    //MARK: -
    //MARK: IBActions
    
    //| ----------------------------------------------------------------------------
    //! IBAction for the various bar button items shown in this example.
    //
    @IBAction func action(sender: AnyObject) {
        NSLog("-[%@ %@]", NSStringFromClass(self.dynamicType), __FUNCTION__)
    }
    
}