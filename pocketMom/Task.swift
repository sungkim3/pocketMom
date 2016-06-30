//
//  Task.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit


class Task: NSObject, NSCoding{
    let text: String
    var completed: Bool
    
    init?(text: String) {
        self.text = text
        self.completed = false
        
        super.init()
        
        if self.text.isEmpty {
            return nil
        }
    }
    
    //MARK: NSCODING
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: TaskKey.textKey)
        aCoder.encodeBool(completed, forKey: TaskKey.completedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObjectForKey(TaskKey.textKey) as! String
        let _ = aDecoder.decodeBoolForKey(TaskKey.completedKey)
        
        self.init(text: text)
    }
    
    //MARK: ARCHIVING PATHS
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
}

struct TaskKey {
    static let textKey = "text"
    static let completedKey = "completed"
}