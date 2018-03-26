//
//  AppDelegate.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/11.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

/*
 把当前别人的提交合到自己的或其他分支上
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let visualEffect = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .extraLight))
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let rootVC = RootViewController()
        let nav = UINavigationController.init(rootViewController: rootVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()    //让窗口成为主窗口，并且显示出来, [self.window makeKeyWindow];//让UIWindow成为主窗口
                
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        self.visualEffect.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.visualEffect.alpha = 0.7
        application.keyWindow?.addSubview(visualEffect)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

//    MARK: - 应用后台切换到前台都会调这个方法
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
//    MARK: -- 程序已经被激活时调用的方法
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.visualEffect.removeFromSuperview()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

