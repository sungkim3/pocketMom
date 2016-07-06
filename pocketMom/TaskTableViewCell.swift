//
//  TaskTableViewCell.swift
//  pocketMom
//
//  Created by Sung Kim on 6/30/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    let uncheckedImage = UIImage(named: "unchecked_box")
    let checkedImage = UIImage(named: "checked_box.jpeg")
    
    
    var task: Task! {
        didSet {
            self.taskLabel.text = self.task.text
            
            if self.task.counter == 0 {
                self.countLabel.hidden = true
            } else {
                self.countLabel.hidden = false
                self.countLabel.text = String(self.task.counter)
            }
            
            if self.task.completed == false {
                checkBoxButton.setImage(uncheckedImage, forState: .Normal)
            } else {
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.task.text)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                self.taskLabel.attributedText = attributeString
                checkBoxButton.setImage(checkedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func checkboxSelected(sender: UIButton) {
        if self.task.completed == false {
            self.task.completed = true
            sender.setImage(checkedImage, forState: .Normal)
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.task.text)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.taskLabel.attributedText = attributeString
        } else {
            self.task.completed = false
            self.taskLabel.text = self.task.text
            sender.setImage(uncheckedImage, forState: .Normal)
        }
        
        guard let taskViewController = self.window?.rootViewController?.childViewControllers.first as? TaskViewController else { return }
        let alert = UIAlertController(title: nil, message: "Did you finish your task?", preferredStyle: .Alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
            TaskManager.shared.tasks.removeAtIndex(TaskManager.shared.tasks.indexOf(self.task)!)
            taskViewController.update()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.task.completed = false
            self.taskLabel.text = self.task.text
            sender.setImage(self.uncheckedImage, forState: .Normal)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        alert.view.setNeedsLayout()
        taskViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
