//
//  AppDelegate.swift
//  SmallDay
//
//  Created by Kenfor-YF on 16/4/28.
//  Copyright © 2016年 Kenfor-YF. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setKeyWindow()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMainViewController", name: SD_showMainTabbarController_Notification, object: nil)
        
        return true
    }
    private func setKeyWindow(){
        window = UIWindow(frame: MainBounds)
        window?.rootViewController = showLeadPage()
        window?.makeKeyAndVisible()
    }
    //在一个消息处理结束后调用
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
   //MARK: -引导页设置
    private func showLeadPage() -> UIViewController {
        let versionStr = "CFBundleShortVersionString"
        let currentVersion = NSBundle.mainBundle().infoDictionary![versionStr] as! String
        let oldVersion = (NSUserDefaults.standardUserDefaults().objectForKey(versionStr) as? String) ?? ""
        //当前的版本号大于老版本,那么就运行新特性界面.(代表程序已经更新了)
        if currentVersion.compare(oldVersion) == NSComparisonResult.OrderedDescending{
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: versionStr)
            NSUserDefaults.standardUserDefaults().synchronize()
            return LeadPageViewControl()
        }
        return MainTabBarController()
    }
    //监听通知,展示首页
    func showMainViewController(){
        
    }


}

