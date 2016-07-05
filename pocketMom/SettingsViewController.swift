//
//  SettingsViewController.swift
//  pocketMom
//
//  Created by Sung Kim on 7/1/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    
    func settingsViewControllerDidFinish()
}

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    
 
    
    var notificationDates = [NotificationDate]()
    
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupNavBarButton()
        self.startTextField.delegate = self
        self.endTextField.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func presentDatePicker(sender: UITapGestureRecognizer) {
        let datePicker = setupDatePicker()
        self.startTextField.inputView = datePicker
        self.startTextField.becomeFirstResponder()
        datePicker.addTarget(self, action: #selector(SettingsViewController.startTimeChanged(_:)), forControlEvents: .ValueChanged)
    }
    
    @IBAction func presentEndDatePicker(sender: UITapGestureRecognizer) {
        let datePicker = setupDatePicker()
        self.endTextField.inputView = datePicker
        self.endTextField.becomeFirstResponder()
        datePicker.addTarget(self, action: #selector(SettingsViewController.endTimeChanged(_:)), forControlEvents: .ValueChanged)
    }
    

}

extension SettingsViewController: Setup {
    
    func setup() {
        self.navigationItem.title = "Settings"
    }
    
    func setupAppearance() {
        //
    }
    
    func setupNavBarButton() {
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(SettingsViewController.saveButtonClicked(_:))), animated: true)
    }
    
    func saveButtonClicked (sender: UIBarButtonItem) {
        print("clicked")
//        let formatter = NSDateFormatter()
//        let timeZone = NSTimeZone(name: "UTC")
//        formatter.timeZone = timeZone
//        if let startText = self.startTextField.text {
//            print(startText)
//            if let startTime = formatter.dateFromString(startText) {
//                print(startTime)
//                self.notificationDates.append(NotificationDate(notificationTime: startTime))
//
//            }
//        }
//        if let endText = self.endTextField.text {
//            if let endTime = formatter.dateFromString(endText) {
//                self.notificationDates.append(NotificationDate(notificationTime: endTime))
//            }
//        }
//        NotificationDate.composeNotificationDate()
    }
}

//MARK: DATEPICKER
extension SettingsViewController {
    
    func setupDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Time
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(datePickerClosed))
        self.view.addGestureRecognizer(tapGesture)
        return datePicker
    }
    
    func datePickerClosed(sender: UITapGestureRecognizer) {
        self.startTextField.resignFirstResponder()
        self.endTextField.resignFirstResponder()
    }
    
    func startTimeChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateFormat = "k:mm"
          self.startTextField.text = formatter.stringFromDate(sender.date)
    }
    
    func endTimeChanged(sender: UIDatePicker) {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateFormat = "k:mm"
        self.endTextField.text = formatter.stringFromDate(sender.date)
    }
}
