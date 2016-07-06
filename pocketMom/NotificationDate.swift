//
//  NotificationDate.swift
//  pocketMom
//
//  Created by Sung Kim on 7/1/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class NotificationDate {
    
    class func composeStartEndNotificationDate() {
        //current date
        let date = NSDate()
        //current calendar
        let calendar = NSCalendar.currentCalendar()
        //needs to fire today or tomorrow
        let dayComponent = calendar.component(.Day, fromDate: date)
        //use hour time to determine which day to fire
        let hourComponent = calendar.component(.Hour, fromDate: date)
        
        //custom NSDate for fireDate
        let dateComp = NSDateComponents()
        //fire start local notification at 6AM
        dateComp.hour = 6
        //fire end local notification at 10PM
        let endDateComp = NSDateComponents()
        endDateComp.hour = 22
        
        //fire tomorrow if current hour is greater than 6AM
        if hourComponent > 6 {
            dateComp.day = dayComponent.successor()
            endDateComp.day = dayComponent.successor()
        }

        let fireDate = calendar.dateByAddingComponents(dateComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
        let endFireDate = calendar.dateByAddingComponents(endDateComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
        
        let startNotification = UILocalNotification()
        startNotification.alertBody = "Wake yo ass up and lets get this day started!"
        startNotification.timeZone = NSTimeZone.localTimeZone()
        startNotification.fireDate = fireDate
//        startNotification.fireDate = NSDate().dateByAddingTimeInterval(10)

        
        let endNotification = UILocalNotification()
        endNotification.alertBody = "What did you get done?"
        endNotification.timeZone = NSTimeZone.localTimeZone()
        endNotification.fireDate = endFireDate
//        endNotification.fireDate = NSDate().dateByAddingTimeInterval(20)

        
        UIApplication.sharedApplication().scheduleLocalNotification(startNotification)
        UIApplication.sharedApplication().scheduleLocalNotification(endNotification)
    }
    
    class func setNotifications() {
        var highestCount = 0
        for task in TaskManager.shared.tasks {
            if highestCount > Int(task.counter) {
                highestCount = Int(task.counter)
            }
        }
        switch highestCount {
        //start and end notifications only
        case 0: NotificationDate.composeStartEndNotificationDate()
        //make one notification at 2PM
        case 1...2: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(14)
        //make three notifications at 10AM and 2PM and 6PM
        case 3...4: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(18)
        //make seven notifications at 8AM, 10AM, 12PM, 2PM, 4PM, 6PM, and 8PM
        case 4...6: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(8)
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(12)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(16)
            NotificationDate.composeNotification(18)
            NotificationDate.composeNotification(20)
        //make fifteen notifications at every hour
        default: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(7)
            NotificationDate.composeNotification(8)
            NotificationDate.composeNotification(9)
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(11)
            NotificationDate.composeNotification(12)
            NotificationDate.composeNotification(13)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(15)
            NotificationDate.composeNotification(16)
            NotificationDate.composeNotification(17)
            NotificationDate.composeNotification(18)
            NotificationDate.composeNotification(19)
            NotificationDate.composeNotification(20)
            NotificationDate.composeNotification(21)
        }
    }
    
    class func composeNotification(hour: Int) {
        //grab current date, access calendar, create a custom hour
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let dateComp = NSDateComponents()
        dateComp.hour = hour
        //set fireDate to the current date with the custom hour
        let fireDate = calendar.dateByAddingComponents(dateComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
        //create new notification with specified parameters
        let notification = UILocalNotification()
        notification.alertBody = "Did you accomplish anything yet? Check your list."
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.fireDate = fireDate
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}
