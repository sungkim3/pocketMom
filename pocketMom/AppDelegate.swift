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
        
        //grab a snap shot of the date (today)
        //dont forget to persist
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        //current date
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dayComponent = calendar.component(.Day, fromDate: currentDate)
        
        
        //check previous saved date and todays date (comparing days)
        for task in TaskManager.shared.tasks {
            task.counter = dayComponent - task.createdAt
        }
    }
    

}

