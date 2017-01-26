//
//  addRunGroupDetailViewController.swift
//  I Runna
//
//  Created by Evan Peterson on 1/25/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit

class addRunGroupDetailViewController: UIViewController {

    @IBOutlet weak var runGroupLogo: UIView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        runGroupLogo.layer.borderWidth = 1
        runGroupLogo.layer.masksToBounds = false
        runGroupLogo.layer.borderColor = UIColor.black.cgColor
        runGroupLogo.layer.cornerRadius = runGroupLogo.frame.height/2
        runGroupLogo.clipsToBounds = true
    }
    
    func photoSelectViewControllerSelectedImage(image: UIImage) {
        self.image = image
    }
    


    // MARK: - Navigation

    // Update for location
    @IBAction func saveGroupRunButtonTapped(_ sender: Any) {
        if let image = image {
            runGroupController.sharedController.createRunGroup(image: image, name: "", pace: "")
            dismiss(animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Missing information", message: "Check your above information", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickImage" {
        }
    }
}
