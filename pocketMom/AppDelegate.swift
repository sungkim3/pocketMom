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
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: nil))
        NotificationDate.composeStartEndNotificationDate()
        
        //every 3 hours
        application.setMinimumBackgroundFetchInterval(60*60*3)
//        application.setMinimumBackgroundFetchInterval(60*15)
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        print("Background fetch is happening")
        if let previousDate = NSUserDefaults.standardUserDefaults().objectForKey("previousDate") as? NSDate {
            
            let currentDate = NSDate()
            let calendar = NSCalendar.currentCalendar()
            calendar.locale = NSLocale.currentLocale()
            calendar.timeZone = NSTimeZone(abbreviation: "GMT")!
            
            let previousDayComponent = calendar.component(.Day, fromDate: previousDate)
//            let previousDayComponent = 6
            let currentDayComponent = calendar.component(.Day, fromDate: currentDate)
            
            print("prev saved day : \(previousDayComponent)")
            print("curr saved day : \(currentDayComponent)")
//            let minuteComponent = calendar.component(.Minute, fromDate: previousDate)
//            let currentMinComponent = calendar.component(.Minute, fromDate: currentDate)
            
            //moved into the next day
//            if minuteComponent != currentMinComponent {
//                //cancel all scheduled localnotifications
//                application.cancelAllLocalNotifications()
//                //schedule notifications based on task object counter property
//                NotificationDate.setNotifications()
//                let previousDate = currentDate
//                NSUserDefaults.standardUserDefaults().setObject(previousDate, forKey: "previousDate")
//            }
            if previousDayComponent != currentDayComponent {
                application.cancelAllLocalNotifications()
                NotificationDate.setNotifications()
                let previousDate = currentDate
                NSUserDefaults.standardUserDefaults().setObject(previousDate, forKey: "previousDate")
            }
        } else {
            NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey:"previousDate")

        }
        completionHandler(.NewData)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        TaskManager.shared.saveTasks()
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        let currentDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
//        let minuteComponent = calendar.component(.Minute, fromDate: currentDate)
//        print("Current Minute for Task Counter is : \(minuteComponent)")
        //check previous saved date and todays date (comparing days)
        for task in TaskManager.shared.tasks {
            if let date = task.createdAt {
                print("the createdAt Date: \(date)")
                let date1 = calendar.startOfDayForDate(date)
                let date2 = calendar.startOfDayForDate(currentDate)
                let flags = NSCalendarUnit.Day
                let components = calendar.components(flags, fromDate: date1, toDate: date2, options: [])
                task.counter = Int32(components.day)
                
//                let flags = NSCalendarUnit.Minute
//                let components = calendar.components(flags, fromDate: date, toDate: currentDate, options: [])
//                print(components.minute)
//                task.counter = Int32(components.minute)
                
                print("task counter is : \(task.counter)")
            }
        }
    }
}

