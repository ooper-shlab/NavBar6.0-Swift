//
//  CustomNavigationBar.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 Subclass of UINavigationBar that displays a button above the
  navigation bar's contents.
 */

import UIKit

@objc(CustomNavigationBar)
class CustomNavigationBar: UINavigationBar {
    
    //! The button to display above the primary contents of the navigation bar.
    var customButton: UIButton? {
        didSet {
            didSetCustomButton(oldValue)
        }
    }
    
    //| ----------------------------------------------------------------------------
    //  A navigation bar subclass should override -sizeThatFits: to pad the fitting
    //  height for the navigation bar, creating space for the extra elements that
    //  will be added.  UINavigationController calls this method to retrieve the
    //  size of the navigation bar, which it then uses when computing the bar's
    //  frame.
    //
    override func sizeThatFits(size: CGSize) -> CGSize {
        var navigationBarSize = super.sizeThatFits(size)
        
        // Pad the base navigation bar height by the fitting height of our button.
        let buttonSize = self.customButton?.sizeThatFits(CGSizeMake(size.width, 0)) ?? CGSize()
        navigationBarSize.height += buttonSize.height
        
        return navigationBarSize
    }
    
    
    //| ----------------------------------------------------------------------------
    override func layoutSubviews() {
        // UINavigationBar positions its elements along the bottom edge of the
        // bar's bounds.  This allows our subclass to position our custom elements
        // at the top of the navigation bar, in the extra space we created by
        // padding the height returned from -sizeThatFits:
        super.layoutSubviews()
        
        // NOTE: You do not need to account for the status bar height in your
        //       layout.  The navigation bar is positioned just below the
        //       status bar by the navigation controller.
        
        // Retrieve the button's fitting height and position the button along the
        // top edge of the navigation bar.  The button is sized to the full
        // width of the navigation bar as it will automatically center its contents.
        let buttonSize = self.customButton?.sizeThatFits(CGSizeMake(self.bounds.size.width, 0)) ?? CGSize()
        self.customButton?.frame = CGRectMake(0, 0, self.bounds.size.width, buttonSize.height)
    }
    
    
    //| ----------------------------------------------------------------------------
    //  Custom implementation of the setter for the customButton property.
    //
    private func didSetCustomButton(customButton: UIButton?) {
        // Remove the previous button
        customButton?.removeFromSuperview()
        
        self.addSubview(self.customButton!)
        
        // Force our -sizeThatFits: method to be called again and flag the
        // navigation bar as needing layout.
        self.invalidateIntrinsicContentSize()
        self.setNeedsLayout()
    }
    
}