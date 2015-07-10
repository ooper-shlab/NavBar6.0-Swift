//
//  CustomBackButtonViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates using a custom back button image with no chevron and
  not text.
 */

import UIKit

@objc(CustomBackButtonViewController)
class CustomBackButtonViewController: UITableViewController {
    
    //! An array of city names, populated from Cities.json.
    private var cities: NSArray?
    
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load some data to populate the table view with
        let citiesJSONURL = NSBundle.mainBundle().URLForResource("Cities", withExtension: "json")
        let citiesJSONData = NSData(contentsOfURL: citiesJSONURL!)!
        try! self.cities = NSJSONSerialization.JSONObjectWithData(citiesJSONData, options: []) as? NSArray
        
        // Note that images configured as the back bar button's background do
        // not have the current tintColor applied to them, they are displayed
        // as it.
        var backButtonBackgroundImage = UIImage(named: "Menu")
        // The background should be pinned to the left and not stretch.
        backButtonBackgroundImage = backButtonBackgroundImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, backButtonBackgroundImage!.size.width - 1, 0, 0))
        
        let appearance: UIBarButtonItem
        if #available(iOS 9.0, *) {
            appearance = UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([CustomBackButtonNavController.self])
        } else {
            appearance = UIBarButtonItem.oop_appearanceWhenContainedIn(CustomBackButtonNavController.self)
        }
        appearance.setBackButtonBackgroundImage(backButtonBackgroundImage, forState: .Normal, barMetrics: .Default)
        
        // Provide an empty backBarButton to hide the 'Back' text present by
        // default in the back button.
        //
        // NOTE: You do not need to provide a target or action.  These are set
        //       by the navigation bar.
        // NOTE: Setting the title of this bar button item to ' ' (space) works
        //       around a bug in iOS 7.0.x where the background image would be
        //       horizontally compressed if the back button title is empty.
        let backBarButton = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        
        // NOTE: There is a bug in iOS 7.0.x where the background of the back bar
        //       button item will not appear until the back button has been tapped
        //       once.
    }
    
    
    //| ----------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            (segue.destinationViewController as! CustomBackButtonDetailViewController).city = self.cities?[self.tableView.indexPathForSelectedRow?.row ?? 0] as! String?
        }
    }
    
    //MARK: -
    //MARK: UITableViewDataSource
    
    //| ----------------------------------------------------------------------------
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities?.count ?? 0
    }
    
    
    //| ----------------------------------------------------------------------------
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = self.cities?[indexPath.row] as! String?
        
        return cell
    }
    
}