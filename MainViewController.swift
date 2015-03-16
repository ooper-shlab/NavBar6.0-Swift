//
//  MainViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The application's main (initial) view controller.
 */

import UIKit

@objc(MainViewController)
class MainViewController: UITableViewController, UIActionSheetDelegate {
    
    
    //| ----------------------------------------------------------------------------
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    
    //| ----------------------------------------------------------------------------
    //  Unwind action that is targeted by the demos which present a modal view
    //  controller, to return to the main screen.
    //
    @IBAction func unwindToMainViewController(UIStoryboardSegue) {
    }
    
    //MARK: -
    //MARK: Style Action Sheet
    
    //| ----------------------------------------------------------------------------
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        // Change the navigation bar style
        switch buttonIndex {
        case 0: // "Default"
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Default
            // Bars are translucent by default.
            self.navigationController?.navigationBar.translucent = true
            // Reset the bar's tint color to the system default.
            self.navigationController?.navigationBar.tintColor = nil
        case 1: // "Black Opaque"
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.translucent = false
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        case 2: // "Black Translucent"
            self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
            self.navigationController?.navigationBar.translucent = true
            self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        default:
            break
        }
        
        // Ask the system to re-query our -preferredStatusBarStyle.
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    //| ----------------------------------------------------------------------------
    //! IBAction for the 'Style' bar button item.
    //
    @IBAction func styleAction(AnyObject) {
        let styleAlert = UIActionSheet(title: NSLocalizedString("Choose a UIBarStyle:", comment: ""),
            delegate: self,
            cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
            destructiveButtonTitle: nil)
        styleAlert.addButtonWithTitle(NSLocalizedString("Default", comment: ""))
        styleAlert.addButtonWithTitle(NSLocalizedString("Black Opaque", comment: ""))
        styleAlert.addButtonWithTitle(NSLocalizedString("Black Translucent", comment: ""))
        
        // use the same style as the nav bar
        styleAlert.actionSheetStyle = UIActionSheetStyle(rawValue: self.navigationController!.navigationBar.barStyle.rawValue)!
        
        styleAlert.showInView(self.view)
    }
    
}