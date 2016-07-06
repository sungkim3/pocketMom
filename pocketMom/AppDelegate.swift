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
        NotificationDate.composeStartEndNotificationDate()
        
        //every 6 hours
        application.setMinimumBackgroundFetchInterval(60*60*6)
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
       
        //if there is a previously saved date
        if let previousDate = NSUserDefaults.standardUserDefaults().objectForKey("previousDate") as? NSDate {
            let currentDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let previousDayComponent = calendar.component(.Day, fromDate: previousDate)
            let currentDayComponent = calendar.component(.Day, fromDate: currentDate)
            
            //moved into the next day
            if previousDayComponent != currentDayComponent {
                //cancel all scheduled localnotifications
                application.cancelAllLocalNotifications()
                //schedule notifications based on task object counter property
                NotificationDate.setNotifications()
            }
            let previousDate = currentDate
            NSUserDefaults.standardUserDefaults().setObject(previousDate, forKey: "previousDate")
        
        } else {
        //if there is no previously saved date (first log in) store the date
            NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey:"previousDate")
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        TaskManager.shared.saveTasks()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dayComponent = calendar.component(.Day, fromDate: currentDate)
//        let minuteComponent = calendar.component(.Minute, fromDate: currentDate)
        
        //check previous saved date and todays date (comparing days)
        for task in TaskManager.shared.tasks {


            if let date = task.createdAt {
                let dayAt = task.getDay(date)
                task.counter = Int32(dayComponent - dayAt)
//                task.counter = Int32(minuteComponent - minuteAt)
            }
        }
    }
}

