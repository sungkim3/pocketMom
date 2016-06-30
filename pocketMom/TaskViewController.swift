//
//  ViewController.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func addButtonSelected(sender: AnyObject) {
        let alertController = UIAlertController(title: "New Task", message: "Enter new Task", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = ""
        }
        
        let addTaskAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            let textField = alertController.textFields![0] as UITextField
            print("Entered Task: \(textField.text)")
            if let taskText = textField.text {
                if let newTask = Task(text: String(taskText)) {
                    self.tasks.append(newTask)
                    for task in self.tasks {
                        print(task.text)
                    }
                    print(self.tasks)
                    self.saveTasks()
                    self.update()
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(addTaskAction)
        alertController.addAction(cancelAction)
        
        alertController.view.setNeedsLayout()
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func update() {
        if let savedTasks = loadTasks() {
            self.tasks += savedTasks
        }
        
        self.loadTasks()
    }
    
    //MARK: NSCODING
    
    func saveTasks() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tasks, toFile: Task.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save tasks...")
        } else {
            print("Saved successfully!")
        }
    }
    
    func loadTasks() -> [Task]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Task.ArchiveURL.path!) as? [Task]
    }
}

extension TaskViewController: Setup {
    
    func setup() {
        self.navigationItem.title = "Task List"
    }
    
    func setupAppearance() {
        //
    }
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath)
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.text
        return cell
    }
}