//
//  NavigationController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 A UINavigationController subclass that always defers queries about
  its preferred status bar style and supported interface orientations to its
  child view controllers.
 */

import UIKit

@objc(NavigationController)
class NavigationController: UINavigationController {
    
    //| ----------------------------------------------------------------------------
    //  Defer returning the supported interface orientations to the navigation
    //  controller's top-most view controller.
    //
    override func supportedInterfaceOrientations() -> Int {
        return self.topViewController.supportedInterfaceOrientations()
    }
    
}
