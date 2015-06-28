//
//  CustomTitleViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates configuring the navigation bar to use a UIView
  as the title.
 */

@objc(CustomTitleViewController)
class CustomTitleViewController: UIViewController {
    
    //| ----------------------------------------------------------------------------
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentTextContent: [String] = [
            NSLocalizedString("Image", comment: ""),
            NSLocalizedString("Text", comment: ""),
            NSLocalizedString("Video", comment: ""),
        ]
        
        // Segmented control as the custom title view
        let segmentedControl = UISegmentedControl(items: segmentTextContent)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        segmentedControl.frame = CGRectMake(0, 0, 400.0, 30.0)
        segmentedControl.addTarget(self, action: "action:", forControlEvents: .ValueChanged)
        
        self.navigationItem.titleView = segmentedControl
    }
    
    
    //| ----------------------------------------------------------------------------
    //! IBAction for the segmented control.
    //
    @IBAction func action(sender: AnyObject) {
        NSLog("-[%@ %@], Selected segment is: %zi", NSStringFromClass(self.dynamicType), __FUNCTION__, sender.selectedSegmentIndex!)
    }
    
}