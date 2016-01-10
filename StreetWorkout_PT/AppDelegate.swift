//
//  AppDelegate.swift
//  StreetWorkoutPT
//
//  Created by Ruben Maia on 24/12/15.
//  Copyright © 2015 ESTG-IPLeiria. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    let yellowColor = UIColor(red: 218.0/255.0, green: 165.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    window?.tintColor = yellowColor
    
    //UINavigationBar UIAppearance
    UINavigationBar.appearance().barTintColor = yellowColor
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    
    let navBarAttrs = [NSForegroundColorAttributeName : UIColor.whiteColor(),
      NSFontAttributeName: UIFont.boldSystemFontOfSize(17)];
    UINavigationBar.appearance().titleTextAttributes = navBarAttrs
    
    //UIBarButtonItem UIAppearance
    let barButtonAttrs = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttrs, forState: .Normal)
    
    return true
  }
}

