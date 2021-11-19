//
//  AppDelegate.swift
//  ExEmailLogin
//
//  Created by 김종권 on 2021/11/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        AppController.shared.show(in: window)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("값")
        print(url)
        return true
    }
    
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//    handleDeepLinkUrl(userActivity.webpageURL)
//    }
}

/*
 func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
   let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
     //...
   }
 }
 */
