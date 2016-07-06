//
//  DateConversion.swift
//  pocketMom
//
//  Created by Sung Kim on 7/5/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func dateFromString(string: String) -> NSDate {
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.timeStyle = NSDateFormatterStyle.NoStyle
        formatter.dateFormat = "k:mm"
        
        return formatter.dateFromString(string)!
    }
    
    class func stringFromDate(date: NSDate) -> String {
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        formatter.timeStyle = NSDateFormatterStyle.NoStyle
        formatter.dateFormat = "k:mm"
        
        return formatter.stringFromDate(date)
    }
    
}