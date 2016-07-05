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
    
    var task: Task! {
        didSet {
            self.taskLabel.text = self.task.text
            
            if self.task.counter == 0 {
                self.countLabel.hidden = true
            } else {
                self.countLabel.hidden = false
                self.countLabel.text = String(self.task.counter)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkboxSelected(sender: Checkbox) {
        if sender.isChecked == false {
            self.task.completed = true
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self.task.text)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            self.taskLabel.attributedText = attributeString
        } else {
            self.task.completed = false
            self.taskLabel.text = self.task.text
        }
    }
}
