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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonSelected(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add New Chore", message: "You have more to do? Shocking.", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.text = ""
        }
        
        let addTaskAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            let textField = alertController.textFields![0] as UITextField
            print("Entered Task: \(textField.text)")
            if let taskText = textField.text {
                if let newTask = Task(text: String(taskText)) {
                    TaskManager.shared.tasks.append(newTask)
                    self.tableView.reloadData()
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(addTaskAction)
        alertController.addAction(cancelAction)
        alertController.view.setNeedsLayout()
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

extension TaskViewController: Setup, TaskTableViewCellDelegate {
    
    func setup() {
        self.navigationItem.title = "pocketMom Chores"
        self.tableView.allowsSelection = false
    }
    
    func setupAppearance() {
        if TaskManager.shared.tasks.count == 0 {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            self.tableView.separatorColor = UIColor.clearColor()
        } else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            self.tableView.separatorColor = UIColor.grayColor()
        }
        self.tableView.reloadData()
    }
    
    func setupTableView() {
        self.tableView.registerNib(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "customTaskCell")
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
    }
    
    func didFinishDeletion(indexPath: NSIndexPath) {
        var indexPathArray = [NSIndexPath]()
        indexPathArray.append(indexPath)
        self.tableView.deleteRowsAtIndexPaths(indexPathArray, withRowAnimation: UITableViewRowAnimation.Left)
        indexPathArray.removeFirst()
    }
}

extension TaskViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.shared.tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customTaskCell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.task = TaskManager.shared.tasks[indexPath.row]
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
        if cell.task.counter == 0 {
            cell.backgroundColor = UIColor.cyanColor()
        } else if cell.task.counter < 3 {
            cell.backgroundColor = UIColor.yellowColor()
        } else if cell.task.counter < 5 {
            cell.backgroundColor = UIColor.orangeColor()
        } else {
            cell.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.4)
        }
        cell.delegate = self
        return cell
    }
}