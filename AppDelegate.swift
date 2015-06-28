//
//  AppDelegate.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The application delegate class.
 */

@UIApplicationMain
@objc(AppDelegate)
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {
    
    var window: UIWindow?
    
    
    //| ----------------------------------------------------------------------------
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        (self.window!.rootViewController as! UINavigationController).delegate = self
        
        return true
    }
    
    //MARK: -
    //MARK: UINavigationControllerDelegate
    
    //| ----------------------------------------------------------------------------
    //  Force the navigation controller to defer to the topViewController for
    //  its supportedInterfaceOrientations.  This allows some of the demos
    //  to rotate into landscape while keeping others in portrait.
    //
    func navigationControllerSupportedInterfaceOrientations(navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return navigationController.topViewController!.supportedInterfaceOrientations()
    }
    
}