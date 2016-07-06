//
//  AppDelegate.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //MARK: LOCAL NOTIFICATION 
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil))
        NotificationDate.composeNotificationDate()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        TaskManager.shared.saveTasks()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        //current date
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
//        let dayComponent = calendar.component(.Day, fromDate: currentDate)
        let minuteComponent = calendar.component(.Minute, fromDate: currentDate)
        
        //check previous saved date and todays date (comparing days)
        for task in TaskManager.shared.tasks {
//            task.counter = dayComponent - task.createdAt

            if let date = task.createdAt {
                let minuteAt = task.getMinute(date)
                task.counter = Int32(minuteComponent - minuteAt)
            }
 
        }
    }
    

}

