//
//  AppDelegate.swift
//  PGQReaderDemo
//
//  Created by Lois_pan on 16/11/10.
//  Copyright © 2016年 Lois_pan. All rights reserved.
//

import UIKit
@objc protocol PGQAppDelegate:NSObjectProtocol {
    
    /// 程序即将退出
    @objc optional func applicationWillTerminate(_ application: UIApplication)
    
    /// 内存警告可能要终止程序
    @objc optional func applicationDidReceiveMemoryWarning(_ application: UIApplication)
    
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var delegate:PGQAppDelegate?

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 允许获取电量
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // 显示状态栏
        application.setStatusBarHidden(false, with: UIStatusBarAnimation.fade)
                
        window = UIWindow(frame:UIScreen.main.bounds)

        // 设置RootVC
        let vc = ViewController()
        
        let navVC = UINavigationController(rootViewController:vc)
        
        window!.rootViewController = navVC
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

