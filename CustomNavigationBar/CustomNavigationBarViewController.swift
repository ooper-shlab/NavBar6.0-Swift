//
//  CustomNavigationBarViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates using a subclass of UINavigationBar with a
  navigation controller.
 */

import UIKit

@objc(CustomNavigationBarViewController)
class CustomNavigationBarViewController: UITableViewController {
    
    //! An array of city names, populated from Cities.json.
    private var cities: NSArray?
    
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load some data to populate the table view with
        let citiesJSONURL = NSBundle.mainBundle().URLForResource("Cities", withExtension: "json")
        let citiesJSONData = NSData(contentsOfURL: citiesJSONURL!)!
        self.cities = NSJSONSerialization.JSONObjectWithData(citiesJSONData, options: nil, error: nil) as! NSArray?
        
        // Create a button and add it to our custom navigation bar.  The button
        // will return the user to the main menu when tapped.
        let returnToMenuButton = UIButton.buttonWithType(.System) as! UIButton
        returnToMenuButton.setTitle(NSLocalizedString("Return to Menu", comment: ""), forState: .Normal)
        returnToMenuButton.titleLabel?.font = returnToMenuButton.titleLabel!.font.fontWithSize(12.0)
        returnToMenuButton.addTarget(self, action: "returnToMenuAction:", forControlEvents: .TouchUpInside)
        (self.navigationController!.navigationBar as! CustomNavigationBar).customButton = returnToMenuButton
    }
    
    
    //| ----------------------------------------------------------------------------
    //  IBAction for the button added to our custom navigation bar.
    //
    @IBAction func returnToMenuAction(AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //| ----------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            (segue.destinationViewController as! CustomNavigationBarDetailViewController).city = self.cities?[self.tableView.indexPathForSelectedRow()?.row ?? 0] as! String?
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.textLabel?.text = self.cities?[indexPath.row] as! String?
        
        return cell
    }
    
}