//
//  NotificationDate.swift
//  pocketMom
//
//  Created by Sung Kim on 7/1/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class NotificationDate {
    
    let notificationTime: NSDate

    init(notificationTime: NSDate) {
        self.notificationTime = notificationTime
    }
    
    class func composeNSDate() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let hourComponent = calendar.component(.Hour, fromDate: date)
        let minuteComponent = calendar.component(.Minute, fromDate: date)
        
        print(date)
        print("current date is: \(calendar)")
        print("current hour is: \(hourComponent)")
        print("current minute is: \(minuteComponent)")
        
//        var dateComp: NSDateComponents = NSDateComponents()
    }
}

//let date = NSDate()
//let calendar = NSCalendar.currentCalendar()
//let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
//let hour = components.hour
//let minutes = components.minute