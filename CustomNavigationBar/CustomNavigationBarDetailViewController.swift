//
//  CustomNavigationBarDetailViewController.swift
//  NavBar
//
//  Translated by OOPer in cooperation with shlab.jp, on 2015/3/14.
//
//
/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 The detail view controller in the Custom Navigation Bar example.
 */

import UIKit

@objc(CustomNavigationBarDetailViewController)
class CustomNavigationBarDetailViewController: UIViewController {
    
    var city: String?
    
    @IBOutlet weak var cityLabel: UILabel?
    
    
    //| ----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityLabel?.text = self.city
    }
    
}