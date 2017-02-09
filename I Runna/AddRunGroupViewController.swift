//
//  addRunGroupDetailViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit
//import UserNotifications

class AddRunGroupViewController: UIViewController, UITextFieldDelegate, PhotoSelectViewControllerDelegate  {

    
    @IBOutlet weak var runPaceTextField: UITextField!
    @IBOutlet weak var locationGroupRunTextField: UITextField!
    @IBOutlet weak var runGroupNameTextField: UITextField!
    @IBOutlet weak var runLogoImageView: UIView!

    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runLogoImageView.layer.cornerRadius = runLogoImageView.frame.size.height/2
        runLogoImageView.layer.masksToBounds = true
        runLogoImageView.layer.borderColor = UIColor.black.cgColor
        runLogoImageView.layer.borderWidth = 2
        
        runPaceTextField.delegate = self
        locationGroupRunTextField.delegate = self
        runGroupNameTextField.delegate = self
        
        runPaceTextField.keyboardType = .decimalPad
        runPaceTextField.keyboardAppearance = .dark
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        runPaceTextField.resignFirstResponder()
        locationGroupRunTextField.resignFirstResponder()
        runGroupNameTextField.resignFirstResponder()
        return true 
    }
    
  
    
    func photoSelectViewControllerSelectedImage(image: UIImage) {
        self.image = image
    }
    


    // MARK: - Navigation

    // Update for location
    
    @IBAction func saveRunButtonTapped(_ sender: Any) {
        guard let rPace = runPaceTextField.text, let doubleRun = Double(rPace) else { return }
        
        if let image = image,
            let name = runGroupNameTextField.text,
            let pace = runPaceTextField.text,
            let location = locationGroupRunTextField.text {
            
            RunGroupController.sharedController.createRunGroup(image: image, name: name, pace: doubleRun, location: location, rInfo: "")
            self.dismiss(animated: true, completion: nil)
        } else if runGroupNameTextField.text == nil {
            let alertController = UIAlertController(title: "Missing information", message: "Check your above information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickImage" {
            guard let nextVC = segue.destination as? PhotoSelectViewController else { return }
            nextVC.delegate = self 
        } 
    }
    
    @IBAction func cancelRunGroupButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}





