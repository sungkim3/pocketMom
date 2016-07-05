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
        self.setupTableView()
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
            if self.tasks.isEmpty {
                self.tasks += savedTasks
            }
        }
        self.loadTasks()
    }
}

extension TaskViewController: Setup {
    
    func setup() {
        self.navigationItem.title = "Task List"
    }
    
    func setupAppearance() {
        //
    }
    
    func setupTableView() {
        self.tableView.registerNib(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "customTaskCell")
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customTaskCell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.task = self.tasks[indexPath.row]
        return cell
    }
    
}

//MARK: NSCODING
extension TaskViewController {

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