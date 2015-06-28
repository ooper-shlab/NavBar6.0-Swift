//
//  CustomAppearanceViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Demonstrates applying a custom background to a navigation bar.
 */

import UIKit

@objc(CustomAppearanceViewController)
class CustomAppearanceViewController: UITableViewController {
    
    @IBOutlet private weak var backgroundSwitcher: UISegmentedControl!
    //! An array of city names, populated from Cities.json.
    private var cities: NSArray?
    
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load some data to populate the table view with
        let citiesJSONURL = NSBundle.mainBundle().URLForResource("Cities", withExtension: "json")
        let citiesJSONData = NSData(contentsOfURL: citiesJSONURL!)!
        try! self.cities = NSJSONSerialization.JSONObjectWithData(citiesJSONData, options: []) as? NSArray
        
        // Place the background switcher in the toolbar.
        let backgroundSwitcherItem = UIBarButtonItem(customView: self.backgroundSwitcher)
        self.toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            backgroundSwitcherItem,
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
        ]
        
        self.applyImageBackgroundToTheNavigationBar()
    }
    
    
    //| ----------------------------------------------------------------------------
    @available(iOS 8.0, *)
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        // This works around a bug in iOS 8.0 - 8.2 in which the navigation bar
        // will not display the correct background image after rotating the device.
        // This bug affects bars in navigation controllers that are presented
        // modally. A bar in the window's rootViewController would not be affected.
        coordinator.animateAlongsideTransition({context in
            // The workaround is to toggle some appearance related setting on the
            // navigation bar when we detect that the view controller has changed
            // interface orientations.  In our example, we call the
            // -configureNewNavBarBackground: which reapplies our appearance
            // based on the current selection.  In a real app, changing just the
            // barTintColor or barStyle would have the same effect.
            self.configureNewNavBarBackground(self.backgroundSwitcher)
            }, completion: nil)

    }
    
    
    //| ----------------------------------------------------------------------------
    //! Configures the navigation bar to use an image as its background.
    //
    private func applyImageBackgroundToTheNavigationBar() {
        // These background images contain a small pattern which is displayed
        // in the lower right corner of the navigation bar.
        var backgroundImageForDefaultBarMetrics = UIImage(named: "NavigationBarDefault")!
        var backgroundImageForLandscapePhoneBarMetrics = UIImage(named: "NavigationBarLandscapePhone")!
        
        // Both of the above images are smaller than the navigation bar's
        // size.  To enable the images to resize gracefully while keeping their
        // content pinned to the bottom right corner of the bar, the images are
        // converted into resizable images width edge insets extending from the
        // bottom up to the second row of pixels from the top, and from the
        // right over to the second column of pixels from the left.  This results
        // in the topmost and leftmost pixels being stretched when the images
        // are resized.  Not coincidentally, the pixels in these rows/columns
        // are empty.
        backgroundImageForDefaultBarMetrics = backgroundImageForDefaultBarMetrics.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, backgroundImageForDefaultBarMetrics.size.height - 1, backgroundImageForDefaultBarMetrics.size.width - 1))
        backgroundImageForLandscapePhoneBarMetrics = backgroundImageForLandscapePhoneBarMetrics.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, backgroundImageForLandscapePhoneBarMetrics.size.height - 1, backgroundImageForLandscapePhoneBarMetrics.size.width - 1))
        
        // You should use the appearance proxy to customize the appearance of
        // UIKit elements.  However changes made to an element's appearance
        // proxy do not effect any existing instances of that element currently
        // in the view hierarchy.  Normally this is not an issue because you
        // will likely be performing your appearance customizations in
        // -application:didFinishLaunchingWithOptions:.  However, this example
        // allows you to toggle between appearances at runtime which necessitates
        // applying appearance customizations directly to the navigation bar.
        /* id navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil]; */
        let navigationBarAppearance = self.navigationController?.navigationBar
        
        // The bar metrics associated with a background image determine when it
        // is used.  The background image associated with the Default bar metrics
        // is used when a more suitable background image can not be found.
        navigationBarAppearance?.setBackgroundImage(backgroundImageForDefaultBarMetrics, forBarMetrics: .Default)
        // The background image associated with the LandscapePhone bar metrics
        // is used by the shorter variant of the navigation bar that is used on
        // iPhone when in landscape.
        navigationBarAppearance?.setBackgroundImage(backgroundImageForLandscapePhoneBarMetrics, forBarMetrics: .Compact)
    }
    
    
    //| ----------------------------------------------------------------------------
    //! Configures the navigation bar to use a transparent background (see-through
    //! but without any blur).
    //
    private func applyTransparentBackgroundToTheNavigationBar(opacity: CGFloat) {
        
        // The background of a navigation bar switches from being translucent
        // to transparent when a background image is applied.  The intensity of
        // the background image's alpha channel is inversely related to the
        // transparency of the bar.  That is, a smaller alpha channel intensity
        // results in a more transparent bar and vis-versa.
        //
        // Below, a background image is dynamically generated with the desired
        // opacity.
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), false, self.navigationController?.navigationBar.layer.contentsScale ?? 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBFillColor(context, 1, 1, 1, opacity)
        UIRectFill(CGRectMake(0, 0, 1, 1))
        let transparentBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // You should use the appearance proxy to customize the appearance of
        // UIKit elements.  However changes made to an element's appearance
        // proxy do not effect any existing instances of that element currently
        // in the view hierarchy.  Normally this is not an issue because you
        // will likely be performing your appearance customizations in
        // -application:didFinishLaunchingWithOptions:.  However, this example
        // allows you to toggle between appearances at runtime which necessitates
        // applying appearance customizations directly to the navigation bar.
        /* id navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil]; */
        let navigationBarAppearance = self.navigationController?.navigationBar
        
        navigationBarAppearance?.setBackgroundImage(transparentBackground, forBarMetrics: .Default)
    }
    
    //| ----------------------------------------------------------------------------
    //! Configures the navigation bar to use a custom color as its background.
    //! The navigation bar remains translucent.
    //
    private func applyBarTintColorToTheNavigationBar() {
        // Be aware when selecting a barTintColor for a translucent bar that
        // the tint color will be blended with the content passing under
        // the translucent bar.  See QA1808 for more information.
        // <https://developer.apple.com/library/ios/qa/qa1808/_index.html>
        let barTintColor = UIColor(red:176/255.0, green:226/255.0, blue:172/255.0, alpha:1.0)
        let darkendBarTintColor = UIColor(red:(176/255.0 - 0.05), green:(226/255.0 - 0.02), blue:(172/255.0 - 0.05), alpha:1.0)
        
        // You should use the appearance proxy to customize the appearance of
        // UIKit elements.  However changes made to an element's appearance
        // proxy do not effect any existing instances of that element currently
        // in the view hierarchy.  Normally this is not an issue because you
        // will likely be performing your appearance customizations in
        // -application:didFinishLaunchingWithOptions:.  However, this example
        // allows you to toggle between appearances at runtime which necessitates
        // applying appearance customizations directly to the navigation bar.
        /* id navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[NavigationController class], nil]; */
        let navigationBarAppearance = self.navigationController?.navigationBar
        
        navigationBarAppearance?.barTintColor = darkendBarTintColor
        
        // For comparison, apply the same barTintColor to the toolbar, which
        // has been configured to be opaque.
        self.navigationController?.toolbar.tintColor = barTintColor
        self.navigationController?.toolbar.translucent = false
    }
    
    //MARK: -
    //MARK: Background Switcher
    
    //| ----------------------------------------------------------------------------
    @IBAction func configureNewNavBarBackground(sender: UISegmentedControl) {
        // Reset everything.
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)
        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Compact)
        self.navigationController?.navigationBar.tintColor = nil
        self.navigationController?.toolbar.tintColor = nil
        self.navigationController?.toolbar.translucent = true
        
        switch sender.selectedSegmentIndex {
        case 0: /* Transparent Background */
            self.applyImageBackgroundToTheNavigationBar()
        case 1: /* Transpaent */
            self.applyTransparentBackgroundToTheNavigationBar(0.87)
        case 2: /* Color */
            self.applyBarTintColorToTheNavigationBar()
        default:
            break
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
    
    //MARK: -
    //MARK: UITableViewDelegate
    
    //| ----------------------------------------------------------------------------
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.navigationItem.prompt == self.cities?[indexPath.row] as! String? {
            self.navigationItem.prompt = nil
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            self.navigationItem.prompt = self.cities?[indexPath.row] as! String?
        }
    }
    
}