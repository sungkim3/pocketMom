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
    let checkedImage = UIImage(named: "checked_box")
    let checkmark = UIImage(named: "checkmark")

    
    weak var delegate: TaskTableViewCellDelegate?
    
    var task: Task! {
        didSet {
            self.taskLabel.text = self.task.text
            
//            if self.task.counter == 0 {
//                self.countLabel.hidden = true
//            } else {
//                self.countLabel.hidden = false
                self.countLabel.text = "Days slacked off: \(self.task.counter)"
//            }
            
            if self.task.completed == false {
                checkBoxButton.setImage(nil, forState: .Normal)
            } else {
                let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.task.text)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                self.taskLabel.attributedText = attributeString
                checkBoxButton.setImage(checkmark, forState: .Normal)
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
            sender.setImage(checkmark, forState: .Normal)
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.task.text)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.taskLabel.attributedText = attributeString
        } else {
            self.task.completed = false
            self.taskLabel.text = self.task.text
            sender.setImage(nil, forState: .Normal)
//            sender.setImage(uncheckedImage, forState: .Normal)
        }
        
        guard let taskViewController = self.window?.rootViewController?.childViewControllers.first as? TaskViewController else { return }
        
        let alert = UIAlertController(title: nil, message: "Did you really finish this chore?", preferredStyle: .Alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
            guard let delegate = self.delegate else { return }
            if let index = TaskManager.shared.tasks.indexOf(self.task) {
                TaskManager.shared.tasks.removeAtIndex(index)
                delegate.didFinishDeletion(NSIndexPath(forRow: index, inSection: 0))
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.task.completed = false
            self.taskLabel.text = self.task.text
            sender.setImage(nil, forState: .Normal)
//            sender.setImage(self.uncheckedImage, forState: .Normal)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        alert.view.setNeedsLayout()
        taskViewController.presentViewController(alert, animated: true, completion: nil)
    }
}
