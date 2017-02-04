//
//  AddRunViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 2/1/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class AddRunViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var runDetail: UITextField!
    @IBOutlet weak var runLocation: UITextField!
    @IBOutlet weak var runName: UITextField!
    @IBOutlet weak var runLength: UITextField!
    @IBOutlet weak var runDateTime: UITextField!
    
    var datePicker: UIDatePicker?
    
    var toolBar: UIToolbar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar().ToolbarPicker(mySelect: #selector(AddRunViewController.dismissPicker))
        runDateTime.inputAccessoryView = toolBar
        
        runLength.keyboardType = UIKeyboardType.decimalPad
        runLength.keyboardAppearance = .dark
        self.view.addSubview(runLength)
        
    }
    
    
    func dismissPicker() {
        view.endEditing(true)
    }

    
    func datePickerChanged(sender: UIDatePicker) {
        var formatter = DateFormatter()
        runDateTime.text = formatter.string(for: sender.date)
    
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func dateTimeTextField(_ sender: UITextField) {
    
        let datePickerView: UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddRunViewController.datePickerChanged), for: UIControlEvents.valueChanged)
        datePicker = datePickerView
   
    }
    
    @IBAction func SaveRunButtonTapped(_ sender: Any) {
        if let rDetails = runDetail.text, let rLocation = runLocation.text, let rName = runName.text, let rLength = runLength.text, let rDateTime = datePicker?.date {
            RunInfoController.sharedController.createRun(dateTime: rDateTime, rLength: Double(rLength)!, rName: rName, runLocation: rLocation, rDetails: rDetails)
            self.dismiss(animated: true, completion: nil)
        }
        let alertController = UIAlertController(title: "Missing information", message: "Check your run info", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
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
