//
//  ExtendedNavBarViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates vertically extending the navigation bar.
 */

@objc(ExtendedNavBarViewController)
class ExtendedNavBarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    //! An array of city names, populated from Cities.json.
    var cities: NSArray?
    
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load some data to populate the table view with
        let citiesJSONURL = NSBundle.mainBundle().URLForResource("Cities", withExtension: "json")
        let citiesJSONData = NSData(contentsOfURL: citiesJSONURL!)!
        try! self.cities = NSJSONSerialization.JSONObjectWithData(citiesJSONData, options: []) as? NSArray
        
        // For the extended navigation bar effect to work, a few changes
        // must be made to the actual navigation bar.  Some of these changes could
        // be applied in the storyboard but are made in code for clarity.
        
        // Translucency of the navigation bar is disabled so that it matches with
        // the non-translucent background of the extension view.
        self.navigationController?.navigationBar.translucent = false
        
        // The navigation bar's shadowImage is set to a transparent image.  In
        // conjunction with providing a custom background image, this removes
        // the grey hairline at the bottom of the navigation bar.  The
        // ExtendedNavBarView will draw its own hairline.
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "TransparentPixel")
        // "Pixel" is a solid white 1x1 image.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"Pixel"), forBarMetrics: .Default)
    }
    
    //MARK: -
    //MARK: UITableViewDataSource
    
    //| ----------------------------------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities!.count
    }
    
    
    //| ----------------------------------------------------------------------------
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.text = self.cities?[indexPath.row] as! String?
        
        return cell!
    }
    
}