//
//  NotificationDate.swift
//  pocketMom
//
//  Created by Sung Kim on 7/1/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class NotificationDate {
    
    class func composeNotificationDate() {
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
        
        let endDateComp = NSDateComponents()
        endDateComp.hour = 21
        
        //fire tomorrow if current hour is greater than 6AM
        if hourComponent > 6 {
            dateComp.day = dayComponent.successor()
            endDateComp.day = dayComponent.successor()
        }

//        let fireDate = calendar.dateByAddingComponents(dateComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
//        let endFireDate = calendar.dateByAddingComponents(endDateComp, toDate: date, options: NSCalendarOptions(rawValue: 0))
        
        let startNotification = UILocalNotification()
        startNotification.alertBody = "Wake yo ass up and lets get this day started!"
        startNotification.timeZone = NSTimeZone.localTimeZone()
//        startNotification.fireDate = fireDate
        startNotification.fireDate = NSDate().dateByAddingTimeInterval(10)
//        startNotification.repeatInterval = .Day
        
        let endNotification = UILocalNotification()
        endNotification.alertBody = "What did you get done?"
        endNotification.timeZone = NSTimeZone.localTimeZone()
//        endNotification.fireDate = endFireDate
        endNotification.fireDate = NSDate().dateByAddingTimeInterval(20)
//        endNotification.repeatInterval = .Day
        
        UIApplication.sharedApplication().scheduleLocalNotification(startNotification)
        UIApplication.sharedApplication().scheduleLocalNotification(endNotification)
    }
    
}
