//
//  Task.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit


class Task: NSObject, NSCoding {
    var text: String
    var completed: Bool
    var counter: Int32
    var createdAt: NSDate?
 

    init?(text: String, completed: Bool = false, counter: Int32 = 0, createdAt: NSDate? = NSDate()) {
        self.text = text
        self.completed = completed
        self.counter = counter
        self.createdAt = createdAt
        
        super.init()
        
        if self.text.isEmpty {
            return nil
        }
    }
    
    func getDay (date: NSDate) -> Int {

        let calendar = NSCalendar.currentCalendar()
        let dayComponent = calendar.component(.Day, fromDate: date)
        return dayComponent
//        let minuteComponent = calendar.component(.Minute, fromDate: date)
//        return minuteComponent
    }
    
    //MARK: NSCODING
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: TaskKey.textKey)
        aCoder.encodeBool(completed, forKey: TaskKey.completedKey)
        aCoder.encodeObject(createdAt, forKey: TaskKey.createdAtKey)
        aCoder.encodeInt(counter, forKey: TaskKey.counterKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObjectForKey(TaskKey.textKey) as! String
        let completed = aDecoder.decodeBoolForKey(TaskKey.completedKey)
        let createdAt = aDecoder.decodeObjectForKey(TaskKey.createdAtKey) as? NSDate
        let counter = aDecoder.decodeIntForKey(TaskKey.counterKey)
        
        self.init(text: text, completed: completed, createdAt: createdAt, counter: counter)
    }
    
    //MARK: ARCHIVING PATHS
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
}

struct TaskKey {
    static let textKey = "text"
    static let completedKey = "completed"
    static let createdAtKey = "createdAt"
    static let counterKey = "counter"
}