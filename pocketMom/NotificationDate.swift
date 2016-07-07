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
        guard let startFireDate = NotificationDate.composeFireDate(6) else { return }
        guard let endFireDate = NotificationDate.composeFireDate(22) else { return }
        
        let startNotification = UILocalNotification()
        startNotification.alertBody = "Wake yo ass up and lets get this day started!"
        startNotification.timeZone = NSTimeZone.localTimeZone()
        startNotification.fireDate = startFireDate

        let endNotification = UILocalNotification()
        endNotification.alertBody = "What did you get done?"
        endNotification.timeZone = NSTimeZone.localTimeZone()
        endNotification.fireDate = endFireDate

        UIApplication.sharedApplication().scheduleLocalNotification(startNotification)
        UIApplication.sharedApplication().scheduleLocalNotification(endNotification)
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
        case 0: NotificationDate.composeStartEndNotificationDate()
        //make one notification at 2PM
            print("queuing 2 notifications")
        case 1...2: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(14)
            print("queuing 3 notifications")
        //make three notifications at 10AM and 2PM and 6PM
        case 3...4: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(18)
            print("queuing 5 notifications")
        //make seven notifications at 8AM, 10AM, 12PM, 2PM, 4PM, 6PM, and 8PM
        case 4...6: NotificationDate.composeStartEndNotificationDate()
            NotificationDate.composeNotification(8)
            NotificationDate.composeNotification(10)
            NotificationDate.composeNotification(12)
            NotificationDate.composeNotification(14)
            NotificationDate.composeNotification(16)
            NotificationDate.composeNotification(18)
            NotificationDate.composeNotification(20)
            print("queuing 9 notifications")
        //make fifteen notifications at every hour
        default: NotificationDate.composeStartEndNotificationDate()
            for index in 7...21 {
                NotificationDate.composeNotification(index)
            }
            print("queuing 17 notifications")
        }
    }
    
    class func composeNotification(hour: Int) {
        guard let fireDate = NotificationDate.composeFireDate(hour) else { return }
        
        //create new notification with specified parameters
        let notification = UILocalNotification()
        notification.alertBody = "Did you accomplish anything yet? Check your list."
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.fireDate = fireDate
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    class func composeFireDate(hour: Int) -> NSDate? {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        calendar.locale = NSLocale.currentLocale()
        calendar.timeZone = NSTimeZone(abbreviation: "GMT")!
        
        let yearComponent = calendar.component(.Year, fromDate: date)
        let monthComponent = calendar.component(.Month, fromDate: date)
        let dayComponent = calendar.component(.Day, fromDate: date)
        let hourComponent = calendar.component(.Hour, fromDate: date)

        
        let dateComp = NSDateComponents()
        dateComp.year = yearComponent
        dateComp.month = monthComponent
        dateComp.day = dayComponent
        dateComp.hour = hour
        dateComp.minute = 0
        dateComp.second = 0
        
        if hourComponent > 6 {
            dateComp.day = dayComponent.successor()
        }
        
        if let fireDate = calendar.dateFromComponents(dateComp) {
            return fireDate
        }
        return nil
    }
    
}
