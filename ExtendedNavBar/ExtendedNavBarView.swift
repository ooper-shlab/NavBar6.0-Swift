//
//  ExtendedNavBarView.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/16.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 A UIView subclass that draws a gray hairline along its bottom
  border, similar to a navigation bar.  This view is used as the navigation
  bar extension view in the Extended Navigation Bar example.
 */

import UIKit

@objc(ExtendedNavBarView)
class ExtendedNavBarView: UIView {
    
    //| ----------------------------------------------------------------------------
    //  Called when the view is about to be displayed.  May be called more than
    //  once.
    //
    override func willMoveToWindow(newWindow: UIWindow?) {
        // Use the layer shadow to draw a one pixel hairline under this view.
        self.layer.shadowOffset = CGSizeMake(0, 1.0/UIScreen.mainScreen().scale)
        self.layer.shadowRadius = 0
        
        // UINavigationBar's hairline is adaptive, its properties change with
        // the contents it overlies.  You may need to experiment with these
        // values to best match your content.
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.25
        
    }
    
}