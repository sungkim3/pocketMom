//
//  NotificationDate.swift
//  pocketMom
//
//  Created by Sung Kim on 7/1/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class NotificationDate {
    
    class func composeNotification(hour: Int) {
        guard let fireDate = NotificationDate.composeFireDate(hour) else { return }
        
        let notification = NotificationDate.composeNotificationBody("Did you accomplish anything yet? Check your list.")
        notification.fireDate = fireDate
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    class func composeStartNotification() {
        guard let startFireDate = NotificationDate.composeFireDate(6) else { return }
        
        let startNotification = NotificationDate.composeNotificationBody("Wake yo ass up and lets get this day started!")
        startNotification.fireDate = startFireDate
        print("start firedate is : \(startNotification.fireDate)")
        
        UIApplication.sharedApplication().scheduleLocalNotification(startNotification)
    }
    
    class func composeEndNotification() {
        guard let endFireDate = NotificationDate.composeFireDate(22) else { return }

        let endNotification = NotificationDate.composeNotificationBody("What did you get done?")
        endNotification.fireDate = endFireDate
        print("end firedate is : \(endNotification.fireDate)")
        
        UIApplication.sharedApplication().scheduleLocalNotification(endNotification)
    }
    
    class func composeNotificationBody(alertBody: String) -> UILocalNotification{
        let notification = UILocalNotification()
        notification.alertBody = alertBody
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.soundName = UILocalNotificationDefaultSoundName
        return notification
    }
    
    class func composeFireDate(hour: Int) -> NSDate? {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        calendar.locale = NSLocale.currentLocale()
        calendar.timeZone = NSTimeZone.localTimeZone()
        
        let yearComponent = calendar.component(.Year, fromDate: date)
        let monthComponent = calendar.component(.Month, fromDate: date)
        let dayComponent = calendar.component(.Day, fromDate: date)
//        let hourComponent = calendar.component(.Hour, fromDate: date)
        
        let dateComp = NSDateComponents()
        dateComp.year = yearComponent
        dateComp.month = monthComponent
        dateComp.day = dayComponent
        dateComp.hour = hour
        dateComp.minute = 53
        dateComp.second = 0
        
//        if hourComponent > 6 {
//            dateComp.day = dayComponent.successor()
//        }
        
        if let fireDate = calendar.dateFromComponents(dateComp) {
            return fireDate
        }
        return nil
    }
    
    class func setNotifications() {
        
        var highestCount = 0
        for task in TaskManager.shared.tasks {
            if highestCount < Int(task.counter) {
                highestCount = Int(task.counter)
            }
        }

        switch highestCount {
        //start and end notifications only
        case 0:
            NotificationDate.composeStartNotification()
            NotificationDate.composeEndNotification()
            print("queuing 2 notifications")
        //make one notification at 2PM            
        case 1...2:
            NotificationDate.composeStartNotification()
            NotificationDate.composeNotification(14)
            NotificationDate.composeEndNotification()
            print("queuing 3 notifications")
        //make three notifications at 10AM and 2PM and 6PM
        case 3...4:
            NotificationDate.composeStartNotification()
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(18)
            NotificationDate.composeEndNotification()
            print("queuing 5 notifications")
        //make seven notifications at 8AM, 10AM, 12PM, 2PM, 4PM, 6PM, and 8PM
        case 4...6:
            NotificationDate.composeStartNotification()
            NotificationDate.composeNotification(8)
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(12)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(16)
            NotificationDate.composeNotification(18)
            NotificationDate.composeNotification(20)
            NotificationDate.composeEndNotification()
            print("queuing 9 notifications")
        //make fifteen notifications at every hour
        default:
            NotificationDate.composeStartNotification()
            for index in 7...21 {
                NotificationDate.composeNotification(index)
            }
            NotificationDate.composeEndNotification()
            print("queuing 17 notifications")
        }
    }

}
