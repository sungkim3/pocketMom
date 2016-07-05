//
//  TaskManager.swift
//  pocketMom
//
//  Created by Sung Kim on 7/5/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import Foundation

class TaskManager {
    
    static let shared = TaskManager()
    
    var tasks: [Task]
    
    private init() {
        if let savedTasks = NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task] {
            self.tasks = savedTasks
        } else {
            self.tasks = [Task]()
        }
    }
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        } else {
            print("Saved successfully!")
        }
    }
    

}