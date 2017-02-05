//
//  AddRunViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/1/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class AddRunViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var runLengthTextField: UITextField!
    @IBOutlet weak var runNameTextField: UITextField!
    @IBOutlet weak var runDetail: UITextField!
    @IBOutlet weak var runLocation: UITextField!
    @IBOutlet weak var runDateTime: UITextField!
    
    var datePicker: UIDatePicker?
    var runInfo: RunInfo?
    var toolBar: UIToolbar?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(AddRunViewController.dismissPicker))
        runDateTime.inputAccessoryView = toolBar
        runLengthTextField.keyboardType = UIKeyboardType.decimalPad
        runLengthTextField.keyboardAppearance = .dark
        self.view.addSubview(runLengthTextField)
        
        
        runLengthTextField.delegate = self
        runNameTextField.delegate = self
        runDetail.delegate = self
        runLocation.delegate = self
        runDateTime.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        runLengthTextField.resignFirstResponder()
        runNameTextField.resignFirstResponder()
        runDetail.resignFirstResponder()
        runLocation.resignFirstResponder()
        runDateTime.resignFirstResponder()
        
        return true
    }
    
    
    func dismissPicker() {
        view.endEditing(true)
    }
    
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        runDateTime.text = formatter.string(for: sender.date)
        
    }
    
    @IBAction func runTimeTextField(_ sender: UITextField) {
        
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddRunViewController.datePickerChanged), for: UIControlEvents.valueChanged)
        datePicker = datePickerView
    }
    
    
    @IBAction func SaveRunButtonTapped(_ sender: Any) {
        guard let runLength = runLengthTextField.text, let doubleRun = Double(runLength) else { return }
        
        
        if let runDetails = runDetail.text,
            let runLocation = runLocation.text,
            let rName = runNameTextField.text,
            let rDateTime = datePicker?.date {
            
            RunInfoController.sharedController.createRun(dateTime: rDateTime, runLength: doubleRun, runName: rName, runLocation: runLocation, runDetails: runDetails)
            _ = navigationController?.popViewController(animated: true)
            
        } else {
            
            let alertController = UIAlertController(title: "Missing information", message: "Check your run info", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createRun" {
            guard let vc = segue.destination as? RunGroupInfoViewController else { return }
            vc.runInfo = runInfo
        }
    }
    
}

extension UIToolbar {
    
    func ToolbarPicker(mySelect: Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
